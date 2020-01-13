package io.zachgray.binauralBeats.engine

case class BinauralBeatsConfiguration(
  pitch: Double = 300,
  binauralPitch: Double = 10,
  duration: Int = 30,
  fileName: Option[String] = None,
  separateFiles: Boolean = false
)
