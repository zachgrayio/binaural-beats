package io.zachgray.binauralBeats.cli

import io.zachgray.binauralBeats.engine.{BinauralBeatsConfiguration, BinauralEngine}
import scopt.OParser

object BinauralApp extends App {
  /**
   * Main function - the entrypoint for the CLI application.
   *
   * Invokes the Binaural Engine with configuration values passed via command line flags.
   * @param args
   */
  override def main(args: Array[String]): Unit = {
    parseBinauralBeatsConfiguration(args) match {
      case Some(config) => BinauralEngine.play(config)
      case _ =>
    }
  }

  /**
   * Parses command line options and returns binaural beats configuration.
   *
   * @param args
   * @return BinauralBeatConfiguration
   */
  private def parseBinauralBeatsConfiguration(args: Array[String]): Option[BinauralBeatsConfiguration] = {
    val builder = OParser.builder[BinauralBeatsConfiguration]
    val optionsParser: OParser[Unit, BinauralBeatsConfiguration] = {
      import builder._
      OParser.sequence(
        programName("binaural"),

        // presets

        cmd("delta")
          .action((_, c) => c.copy(binauralPitch = 3))
          .text("Delta pattern preset; Binaural beats in the delta pattern operate at a frequency of 0.5–4 Hz with links to a dreamless sleep."),

        cmd("theta")
          .action((_, c) => c.copy(binauralPitch = 5.5))
          .text("Theta pattern preset; Practitioners set binaural beats in the theta pattern to a frequency of 4–7 Hz. " +
            "Theta patterns contribute to improved meditation, creativity, and sleep in the rapid eye movement (REM) phase."),

        cmd("alpha")
          .action((_, c) => c.copy(binauralPitch = 10))
          .text("Alpha pattern preset; Binaural beats in the alpha pattern are at a frequency of 7–13 Hz and may encourage relaxation."),

        cmd("beta")
          .action((_, c) => c.copy(binauralPitch = 20))
          .text("Beta pattern preset; Binaural beats in the beta pattern are at a frequency of 13–30 Hz. This frequency range " +
            "may help promote concentration and alertness. However, it can also increase anxiety at the higher end of the range."),

        cmd("gamma")
          .action((_, c) => c.copy(binauralPitch = 40))
          .text("Gamma pattern preset; This frequency pattern accounts for a range of 30–50 Hz. The study authors suggest that " +
            "frequencies promote maintenance of arousal while a person is awake."),

        // full customization

        opt[Double]('p', "pitch")
          .action((x, c) => c.copy(pitch = x))
          .text("the frequency in Hz - an integer property"),

        opt[Double]('b', "binaural_pitch")
          .action((x, c) => c.copy(binauralPitch = x))
          .text("the binaural tone's frequency - a decimal property"),

        opt[Int]('d', "duration")
          .action((x, c) => c.copy(duration = x))
          .text("the duration for which to play the binaural audio - an integer property")
      )
    }
    OParser.parse(optionsParser, args, BinauralBeatsConfiguration())
  }
}
