package io.zachgray.binauralBeats.engine

case class BinauralBeatsConfiguration(
  pitch: Double = 300,
  binauralPitch: Double = 10,
  duration: Long = 120,
  fileName: Option[String] = None,
  separateFiles: Boolean = false
)
