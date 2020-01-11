package io.zachgray.binauralBeats.engine

import io.zachgray.binauralBeats.engine.BinauralEngine.{createBinauralFrameFunction, createDualBinauralFrameFunctions}
import scalaudio.core.types.{Frame, Pitch}
import scalaudio.core.{AudioContext, DefaultAudioContext, ScalaudioConfig}
import scalaudio.units.AmpSyntax
import scalaudio.units.filter.{GainFilter, StereoPanner}
import scalaudio.units.ugen.{OscState, Sine}
import scalaz.Scalaz._

import scala.concurrent.duration._

object BinauralEngine extends AmpSyntax with DefaultAudioContext {

  /**
   * Creates a stereo audio context and invokes playback for the specified configuration.
   *
   * @param binauralBeatConfiguration the configuration of the binaural beats which should be generated.
   */
  def play(binauralBeatConfiguration: BinauralBeatsConfiguration): Unit = {
    playback(
      frameFunc = createBinauralFrameFunction(
        pitch = binauralBeatConfiguration.pitch,
        binauralPitch = binauralBeatConfiguration.binauralPitch
      ),
      duration = binauralBeatConfiguration.duration seconds
    )
  }

  /**
   * Creates a stereo audio context and invokes `record` for the specified configuration.
   *
   * @param config the configuration of the binaural beats which should be generated.
   */
  def writeToFile(config: BinauralBeatsConfiguration): Unit = {
    if (config.separateFiles) {
      writeToSeparateFiles(config)
    } else {
      record(
        fileName = config.fileName.get,
        frameFunc = createBinauralFrameFunction(
          pitch = config.pitch,
          binauralPitch = config.binauralPitch
        ),
        duration = config.duration seconds
      )
    }
  }

  private def writeToSeparateFiles(config: BinauralBeatsConfiguration): Unit = {
    val ffs = createDualBinauralFrameFunctions(config.pitch, config.binauralPitch)
    for((ff, index) <- ffs.zipWithIndex) {
      record(
        fileName = config.fileName.get + "_" + index,
        frameFunc = ff,
        duration = config.duration seconds
      )
    }
  }

  /**
   * Creates a sine frame function with the specified parameters
   *
   * @param pitch the desired pitch of the sine wave
   * @param pan the pan of the signal where 0 = left, 1 = right, 0.5 = center
   * @param gain the gain to be applied to the frame
   * @param audioContext the audio context
   * @return a sine-wave frame function
   */
  private def createSineWaveFrameFunction(pitch: Double, pan: Double, gain: Double)(implicit audioContext: AudioContext): () => Frame = {
    Sine.immutable.asFunction(OscState(0, Pitch(pitch), 0))
      .map(sineState =>
        GainFilter.applyGainToFrame(gain)(
          StereoPanner.pan(pan)(sineState.sample)
        )
      )
  }

  /**
   * Creates a "binaural frame function" with the specified parameters.
   *
   * Any given "binaural frame" will be a single sample of one of two interleaved waves oscillating at the frequencies
   * required to generate a binaural tone with the specified frequncy of `binauralPitch`, panned either fully to the left
   * or to the right.
   *
   * The frame function interleaves samples from each of these two waves, producing one single stereo tone.
   *
   * @param pitch The baseline pitch (in Hz) of the binaural beat
   * @param binauralPitch The pitch of the binaural frequency which should be generated
   * @param audioContext The audio context
   * @return the binaural frame function
   */
  def createBinauralFrameFunction(pitch: Double, binauralPitch: Double)(implicit audioContext: AudioContext): () => Frame = {
    val frameFunctions = createDualBinauralFrameFunctions(pitch, binauralPitch)
    var interleave = false
    () => {
      interleave = !interleave
      frameFunctions(interleave.compare(false))()
    }
  }

  /**
   *
   * @param pitch The baseline pitch (in Hz) of the binaural beat
   * @param binauralPitch The pitch of the binaural frequency which should be generated
   * @param audioContext The audio context
   * @return the binaural frame functions
   */
  def createDualBinauralFrameFunctions(pitch: Double, binauralPitch: Double)(implicit audioContext: AudioContext): Seq[() => Frame] = {
    Seq(
      createSineWaveFrameFunction(pitch, 0, 1),
      createSineWaveFrameFunction(pitch + binauralPitch, 1, 1)
    )
  }
}
