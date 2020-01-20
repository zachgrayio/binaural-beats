# Binaural Beats Generator

A binaural beat is an [auditory illusion](https://en.wikipedia.org/wiki/Auditory_illusion)  [perceived](https://en.wikipedia.org/wiki/Perception) when two different pure-tone [sine waves](https://en.wikipedia.org/wiki/Sine_wave), both with [frequencies](https://en.wikipedia.org/wiki/Frequency) lower than 1500 Hz, with less than a 40 Hz difference between them, are presented to a [listener](https://en.wikipedia.org/wiki/Hearing) dichotically (one through each [ear](https://en.wikipedia.org/wiki/Ear)).

This project defines a number of programs and utilities for generating binaural beats:

- `//engine`: The binaural audio engine: a Scala library which can be consumed by JVM programs
- `//cli`: A Scala CLI program which can generate binaural audio files based on input arguments
- `//dubber`: Some various pydub-based audio utility programs, used during the ensembling steps
- `//dsl`: A Bazel DSL which can be used to define Bazel targets which will generate binaural beats audio files when invoked with Bazel. 

## DSL

### Tutorial:

#### 1: Load the binaural DSL operations we'd like to make use of:

```starlark
load(
    "//dsl:dsl.bzl",
    "binaural_stems",
    "binaural_sequence",
)
```

#### 2: Generate Binaural Stems

Next, we'll invoke the Scala CLI program to generate some "binaural stem tracks".

A "binaural stem track" is a 2 channel (stereo) wav file containing a pure sine wave oscillating at some frequency on exactly one of the channels, with the other being blank. On it's own, there's nothing "binaural" about this audio file, but the CLI program will output two of these files which when taken together will have a binaural beat playing between them.

The binaural CLI program is capable of interleaving these for us, but this is something we'll do manually in a later step for greater control and fidelity.

##### Define some shared parameters:

```starlark
PITCH = 300     # 300 Hz
DURATION = 60   # 60 seconds
```

##### Define first Stem:

This will generate two wav files (left+right) for an alpha wave binaural beat with a baseline pitch of `PITCH`.

Binaural beats in the alpha pattern are at a frequency of 7–13 Hz and may encourage relaxation.

```starlark
binaural_stems(
    name = "alpha-stems",
    pitch = PITCH,
    binaural_pitch = 10,
    duration = DURATION,
)
```


##### Define a second Stem
 
This will output two intermediate wav files for a beta binaural beat.

Binaural beats in the beta pattern are at a frequency of 13–30 Hz. This frequency range may help promote concentration and alertness.

```starlark
binaural_stems(
    name = "beta-stems",
    pitch = PITCH,
    binaural_pitch = 20,
    duration = DURATION
)
```

#### 3: Define Binaural Sequence

Now we'll use these stem tracks as inputs to a Binaural Sequence.

A Binaural Sequence generates a stereo wav file output from an input list of stem tracks. Each "stem" consists of two wav files (one for each channel) so these are first combined into a single merged stem track, and then each of these merged intermediate files are concatenated together in the order specified below to produce the final output audio file.

This creates the final output, alpha-beta-sequence.wav:

```starlark
binaural_sequence(
    name = "alpha-beta-sequence",
    stems = [
        "//:alpha-stems",
        "//:beta-stems",
    ],
)
```

These steps are all that is needed to define advanced, multi-staged binaural beats. See below for information on how to invoke these targets if you're new to Bazel.

### Running:

The `BUILD` file in the repository root defines some targets which can be built with Bazel to generate binarual beats audio files.

- `bazel build //:alpha-beta-sequence` will invoke a target in the root `BUILD` file which defines a sequence of binaural beats which first play an alpha wave and then a beta wave.

## Scala CLI program

This program may be useful on it's own to some users - as such, a simple CLI interface is defined and it can be invoked directly if desired.

### Build & Run from Source:

```bash
bazel run //cli:app -- alpha
```

### Usage:

```
Usage: binaural [delta|theta|alpha|beta|gamma] [options]

Command: delta
Delta pattern preset; Binaural beats in the delta pattern operate at a frequency of 0.5–4 Hz with links to a dreamless sleep.
Command: theta
Theta pattern preset; Practitioners set binaural beats in the theta pattern to a frequency of 4–7 Hz. Theta patterns contribute to improved meditation, creativity, and sleep in the rapid eye movement (REM) phase.
Command: alpha
Alpha pattern preset; Binaural beats in the alpha pattern are at a frequency of 7–13 Hz and may encourage relaxation.
Command: beta
Beta pattern preset; Binaural beats in the beta pattern are at a frequency of 13–30 Hz. This frequency range may help promote concentration and alertness. However, it can also increase anxiety at the higher end of the range.
Command: gamma
Gamma pattern preset; This frequency pattern accounts for a range of 30–50 Hz. The study authors suggest that frequencies promote maintenance of arousal while a person is awake.
  -p, --pitch <value>           the frequency in Hz - an integer property
  -b, --binaural_pitch <value>  the binaural tone's frequency - a decimal property
  -d, --duration <value>        the duration for which to play the binaural audio - an integer property
```

## More About Binaural Beats:
(via Wikipedia)

A binaural beat is an [auditory illusion](https://en.wikipedia.org/wiki/Auditory_illusion)  [perceived](https://en.wikipedia.org/wiki/Perception) when two different pure-tone [sine waves](https://en.wikipedia.org/wiki/Sine_wave), both with [frequencies](https://en.wikipedia.org/wiki/Frequency) lower than 1500 Hz, with less than a 40 Hz difference between them, are presented to a [listener](https://en.wikipedia.org/wiki/Hearing) dichotically (one through each [ear](https://en.wikipedia.org/wiki/Ear)).

For example, if a 530 Hz pure [tone](https://en.wikipedia.org/wiki/Pitch_(music)) is presented to a subject's right ear, while a 520 Hz pure tone is presented to the subject's left ear, the listener will perceive the [auditory illusion](https://en.wikipedia.org/wiki/Auditory_illusion) of a third tone, in addition to the two pure-tones presented to each ear. The third sound is called a binaural beat, and in this example would have a perceived pitch correlating to a frequency of 10 Hz, that being the difference between the 530 Hz and 520 Hz pure tones presented to each ear.[[citation needed](https://en.wikipedia.org/wiki/Wikipedia:Citation_needed)]

Binaural-beat perception originates in the [inferior colliculus](https://en.wikipedia.org/wiki/Inferior_colliculus) of the [midbrain](https://en.wikipedia.org/wiki/Midbrain) and the [superior olivary complex](https://en.wikipedia.org/wiki/Superior_olivary_complex) of the [brainstem](https://en.wikipedia.org/wiki/Brainstem), where [auditory signals](https://en.wikipedia.org/wiki/Audio_signal_processing) from each [ear](https://en.wikipedia.org/wiki/Ear) are integrated and precipitate [electrical impulses](https://en.wikipedia.org/wiki/Action_potential) along [neural pathways](https://en.wikipedia.org/wiki/Neural_pathway) through the [reticular formation](https://en.wikipedia.org/wiki/Reticular_formation) up the midbrain to the [thalamus](https://en.wikipedia.org/wiki/Thalamus), [auditory cortex](https://en.wikipedia.org/wiki/Auditory_cortex), and other cortical regions.[[6]](https://en.wikipedia.org/wiki/Beat_(acoustics)#cite_note-oster-6)

Some potential benefits of binaural beats therapy may include: reduced [stress](https://en.wikipedia.org/wiki/Psychological_stress), reduced [anxiety](https://en.wikipedia.org/wiki/Anxiety), increased focus, increased concentration, increased motivation, increased confidence, and deeper [meditation](https://en.wikipedia.org/wiki/Meditation).[[7]](https://en.wikipedia.org/wiki/Beat_(acoustics)#cite_note-MedicalNewsToday-7)
