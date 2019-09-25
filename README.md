# GIGA-Consciousness MRI Protocol
A clinical and research 3T MRI protocol under 30 minutes, as presented at [CME2019](https://cme2019.ifado.de) in Dortmund.

Version: 1.0.2 - 2019-09-25

## Description

Magnetic Resonance Imagery is a highly flexible tool that can acquire a lot of different contrasts, from structural anatomy and connectivity, to functional connectivity and blood flow. This technology allows both the investigation of brain processes as well as clinical assessment of lesions.

A major issue is that MRI analytic studies often suffer from small sample size and underpowered effects. One way is to attempt to use more specific, better tailored methods to compensate for the low sample size, adding more assumptions in exchange. Another way is to simply acquire more subjects, which is not a trivial task.

Indeed, MRI is very expensive, particularly when the machine is not dedicated to research, such as hospitals' MRI machines. Often, the MRI protocol used on such machines is of subpar quality or technology, to stay in the time bounds of a clinical acquisition. Indeed, there are more patients than time allows, so that hospitals are perpetually looking for ways to reduce acquisition times. On top of that, for populations of patients prone to motion, usually about 2/3rd will not be processable by computational methods.

Reducing the acquisition time is often thought as a limitation, but it can be an opportunity: this allows for more subjects to be acquired in the same timeframe thus increasing the sample size; for patients populations that are prone to motion, having faster sequences allows to reduce the impact of the motion artifacts and the need to sedate; and finally, a fast protocol is more reusable across studies, which is ideal to build cross-sectional datasets of different patients typologies.

This repository contains the protocol of a 30 minutes 3T MRI for the Siemens Magnetom Vida machine, including the following sequences:

- T1 FLAWS (automatically segmented MPRAGE, voxel-size: 1mm³ isotropic)
- Sub-second EPI BOLD (TR: 758 ms, voxel-size: 3mm³ isotropic)
- Multi-shell DWI/DTI (3-shells: b700, b1000, b2000)
- Clinical sequences: FLAIR, SWI, SWI/mIP, PCASL, T2

This protocol was designed over the span of 8 months and is now a standard protocol at the Hospital of Liège, Belgium. So far, 45 subjects (18 healthy volunteers, 17 disorders of consciousness patients, 10 subjects of other studies) have been acquired using this protocol.

For more details, please consult the [CME2019 slides](https://github.com/lrq3000/mri_protocol/blob/master/ICME2019-stephen-karl-larroque.pdf). The protocol can be adapted to other machines by using the pdf printout (see next section).

## How to install

If you own a Siemens Magnetom Vida, the full protocol can be directly imported into your machine by using the [exar1 file](https://github.com/lrq3000/mri_protocol/blob/master/SiemensVidaProtocol/Coma%20Science%20Group%2052.exar1).

Otherwise, for another machine, the [pdf printout](https://github.com/lrq3000/mri_protocol/blob/master/SiemensVidaProtocol/Coma%20Science%20Group%2052.pdf) or [xml printout](https://github.com/lrq3000/mri_protocol/blob/master/SiemensVidaProtocol/Coma%20Science%20Group%2052.pdf) details most parameters (but unfortunately not all, but at least the most important ones) in a human readable format. By using these printouts as a reference, the protocol should be implementable on pretty much any machine, with only basic access to the standard parameters fields (ie, no need for experimental parameters access nor developer console, see the FAQ below for more details).

To use these printouts: only the first 12 sequences are part of the final protocol (up to pcasl included), the rest being test sequences that, for most, do work but were not kept in the final protocol (but feel free to try them out if you are interested). Note also that EPI BOLD and PCASL are duplicated with a different name depending on the patient state (sedated or not), but otherwise all the parameters are the same, so you can keep only one if you are not working with potentially sedated patients.

In order for this protocol to run under 30 minutes, a multiband (Simultaneous Multi-Slices -- SMS for Siemens) license is necessary to activate this technology to reduce the acquisition time of EPI BOLD and Multi-shell DWI. For other sequences, the multiband is not necessary, as only parallel imaging (GRAPPA) and careful tweaking of the pulse parameters are used to accelerate the acquisition.

Meta-protocol wise, a screenshot of the protocol programming can be found in the SiemensVidaProtocol folder. The protocol programming was designed to ensure that:

1. the EPI BOLD sequence is run first (just after the localizer), to ensure the patient is still awake and lesser stressed (and thus reduce the risks of motion and sedation).
2. the multi-shells of DTI acquisition are run using the same coil positioning parameters (on Siemens, use a Copy Reference from the first to the second and third shells).
3. the sequences are renamed depending on the patient's state (ie, sedated or not), which allows an auto-documentation of how the acquisition went, directly stored inside the DICOMs.

We also strongly advise the use of a 3D head immobilizer, as to further reduce motion and the need for sedation.

## Authors & citations

This protocol was thought and programmed by Stephen Karl Larroque. Subjects were acquired by Manon Carrière, Charlotte Martial and Stephen Karl Larroque. The project was supervised by Steven Laureys. All authors are from the University of Liège, Belgium. Stephen Karl Larroque is a doctoral student with a F.R.S.-F.N.R.S. ASP grant, Steven Laureys a research director at F.R.S.-F.N.R.S. We are thankful to Jean-Marc Léonard from Siemens Healthineers for his precious support in programming adequately the machine, to Jean-Flory Tshibanda, Nathalie Maquet and the Radiodiagnostic team for their collaboration, and Pearltec for their partnership and providing us with a 3D head immobilizer (Multipad).

If you find this work useful, please cite it as follows:

(citation to come here)

## Frequently Asked Questions

### What is the target Dot Cockpit version?

The exar1 file should work with the software version introduced with the Siemens Vida, which is X...

For other versions, the sequences can be reproduced using the printouts.

### Do I need the multiband license?

Multiband is necessary for sub-second BOLD and multiband DTI, but not for the rest (eg, FLAWS, requires only MP2RAGE and parallel imaging such as GRAPPA or SENSE).

To get this license, two ways are possible:
* Buy the Siemens SMS license. SMS is based on the CMRR's multiband sequence, it thus has most of the same features with the exception of the newest features that might take more time to be merged in (Siemens waiting for them to be stable) and also some advanced parameters are not available (at least not without developers access). The list of supported machine is listed [here under General Requirements](https://www.siemens-healthineers.com/magnetic-resonance-imaging/options-and-upgrades/clinical-applications/simultaneous-multi-slice).
* And and fill a C2P partnership form with the [CMRR](https://www.cmrr.umn.edu/multiband/) (University of Minnesota), the original authors of the multiband technology. This is an opensource protocol, also used by the [Human Connectome Project (HCP)](http://protocols.humanconnectome.org/CCF/) with more cutting-edge features. Note that the CMRR's protocol supports different machines than Siemens', so it might be interesting to check it out if the SMS license is not supported.

In case you can't have the multiband, it's better to stick to BOLD TR 2s and DTI single-shell b1000 to keep the protocol under a reasonable time constraint.

Also, although multiband is a great speedup, this is not the only optimization that can be done. We would strongly advise to focus efforts on acquiring a 3D head immobilizer, which costs around 2000 euros, but is very worth given the reduction in motion noise and sedation.

### Who owns the rights?

As far as we know, we are the rights owner for this protocol, which is herein distributed under the MIT License.

Technically, all sequences of our protocol stem from base sequences provided by Siemens and modified to fit our needs. This was necessary as we do not have access to the full parametrization of the machine, which is only allowed to trained specialists. For instance, the FLAWS sequence can be recreated by modifying the parameters of the base MP2RAGE sequence.

As such, all sequences should be reproducible on any machine since we modified only "standard" parameters such as inversion time, bandwidth, flip angle, etc. and not any experimental parameter or developer console commands that would be accessible only to trained specialists.