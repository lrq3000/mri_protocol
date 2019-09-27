# GIGA-Consciousness MRI Protocol
A clinical and research 3T MRI protocol under 30 minutes, as presented at [CME2019](https://cme2019.ifado.de) in Dortmund.

Version: 1.0.5 - 2019-09-26

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

The main innovations of this protocol are:

* a curated combination of cutting-edge sequences (sub-second EPI BOLD, multi-shell DTI, T1 FLAWS) to cover most experimental and clinical needs.
* speed optimizations with a good quality balance. Most sequences here are the fastest of all current 3T MRI literature (Multi-shell DTI at 13min, T1 FLAWS in 5min, FLAIR in 3min, SWI in 3min, etc).
* reduced susceptibility to motion and metal/chemical artefacts.

This protocol was designed over the span of 8 months and is now a standard protocol at the Hospital of Liège, Belgium. So far, 45 subjects (18 healthy volunteers, 17 disorders of consciousness patients, 10 subjects of other studies) have been acquired using this protocol.

For more details, please consult the [CME2019 slides](https://github.com/lrq3000/mri_protocol/blob/master/ICME2019-stephen-karl-larroque.pdf). For detailed technical informations and bibliography, please consult [ComplementaryInfosBiblio.md](https://github.com/lrq3000/mri_protocol/blob/master/ComplementaryInfosBiblio.md). The protocol can be adapted to other machines by using the [pdf printout](https://github.com/lrq3000/mri_protocol/blob/master/SiemensVidaProtocol/Coma%20Science%20Group%2052.pdf) (see next section). In an effort to promote transparent open research, the lab notes written along the construction of this protocol are available in the [Notes folder](https://github.com/lrq3000/mri_protocol/tree/master/Notes) (beware, it's very messy, but there's lot of additional infos and references).

## How to install

If you own a 3T Siemens Magnetom Vida, the full protocol can be directly imported into your machine by using the [exar1 file](https://github.com/lrq3000/mri_protocol/blob/master/SiemensVidaProtocol/Coma%20Science%20Group%2052.exar1).

Otherwise, for another machine, the [pdf printout](https://github.com/lrq3000/mri_protocol/blob/master/SiemensVidaProtocol/Coma%20Science%20Group%2052.pdf) or [xml printout](https://github.com/lrq3000/mri_protocol/blob/master/SiemensVidaProtocol/Coma%20Science%20Group%2052.pdf) details most parameters (but unfortunately not all, but at least the most important ones) in a human readable format. By using these printouts as a reference, the protocol should be implementable on pretty much any machine, with only basic access to the standard parameters fields (ie, no need for experimental parameters access nor developer console, see the FAQ below for more details).

To use these printouts: only the first 12 sequences are part of the final protocol (up to pcasl included), the rest being test sequences that, for most, do work but were not kept in the final protocol (but feel free to try them out if you are interested). Note also that EPI BOLD and PCASL are duplicated with a different name depending on the patient state (sedated or not), but otherwise all the parameters are the same, so you can keep only one if you are not working with potentially sedated patients.

In order for this protocol to run under 30 minutes, a multiband (Simultaneous Multi-Slices -- SMS for Siemens) license is necessary to activate this technology to reduce the acquisition time of EPI BOLD and Multi-shell DWI. For other sequences, the multiband is not necessary, as only parallel imaging (GRAPPA) and careful tweaking of the pulse parameters are used to accelerate the acquisition.

Meta-protocol wise, a screenshot of the protocol programming can be found in the SiemensVidaProtocol folder. The protocol programming was designed to ensure that:

1. the EPI BOLD sequence is run first (just after the localizer), to ensure the patient is still awake and lesser stressed (and thus reduce the risks of motion and sedation).
2. the multi-shells of DTI acquisition are run using the same coil positioning parameters (on Siemens, use a Copy Reference from the first to the second and third shells).
3. the sequences are renamed depending on the patient's state (ie, sedated or not), which allows an auto-documentation of how the acquisition went, directly stored inside the DICOMs.

We also strongly advise the use of a 3D head immobilizer, as to further reduce motion and the need for sedation.

## Authors & citations

This protocol was thought and programmed by Stephen Karl Larroque. Subjects were acquired by Manon Carrière, Charlotte Martial and Stephen Karl Larroque. The project was supervised by Steven Laureys. All authors are from the University of Liège, Belgium. Stephen Karl Larroque is a doctoral student with a F.R.S.-F.N.R.S. ASP grant, Steven Laureys a research director at F.R.S.-F.N.R.S.

We are thankful to Jean-Marc Léonard from Siemens Healthineers and Gauthier Kempinaire for their precious support in programming adequately the machine, to Jean-Flory Tshibanda, Nathalie Maquet and the Radiodiagnostic team for their collaboration, and Pearltec for their partnership and providing us with a 3D head immobilizer (Multipad).

If you find this work useful, please cite it as follows:

(citation to come here)

## Frequently Asked Questions

### What is the target version?

The exar1 file should work with the software version introduced with the Siemens Vida, which is VB30 (previous versions on the VIDA had issues with DTI reconstruction). The Dot Cockpit version used is a minor update from [syngo MR E11](http://cbbi.udel.edu/wp-content/uploads/2017/01/Dot_Cockpit.pdf).

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

For multiband, the various names used by the different MRI brands can be found on [mriquestions](http://mriquestions.com/simultaneous-slices.html).

### How can I implement T1 FLAWS from the printout?

To implement T1 FLAWS, you should start from the Siemens native MP2RAGE sequence, and then modify its TI1 and TI2 parameters to the values in the printout. If the TI1 and TI2 parameters can't be lowered enough, play with slice fourier interpolation and plane fourier interpolation. In our case, 7/8 was enough to attain 450 TI1 and 1350 TI2 (with slice fourier 6/8 we can go much lower).

If your machine does not support MP2RAGE, an alternative to FLAWS is FLAIR(2), a combination of FLAIR and T2: FLAIR2 = 3D-FLAIR .* 3D-T2 ; Contrary to FLAWS the images are not necessarily coregistered but it offers CSF nullification and increased WM vs GM contrast compared to DIR (double inversion recovery): Wiggermann, V., Hernandez-Torres, E., Traboulsee, A., Li, D. K. B., & Rauscher, A. (2016). FLAIR2: a combination of FLAIR and T2 for improved MS lesion detection. *American Journal of Neuroradiology*, *37*(2), 259-265.

### I need help with reconstructing the protocol from the printout

Here are some resources that can help you:

* [syngo MR E11 Dot Cockpit manual](http://cbbi.udel.edu/wp-content/uploads/2017/01/Dot_Cockpit.pdf) (in particular the Copy Reference option is described)

* [syngo MR E11 System and data management](http://cbbi.udel.edu/wp-content/uploads/2017/01/Sys-DataManagement.pdf) which is a complementary manual to the Dot Cockpit.

* [Harvard's Center for Brain Science - Operating the scanner FAQ](http://cbs.fas.harvard.edu/science/core-facilities/neuroimaging/information-investigators/scannerfaq) which explains how to operate the MRI machine (on an older syngo version but it's similar), and in particular how to check for errors in the console and how to save the log to send to Siemens Healthineers.

* [syngo MR E11 Neuro operator manual](http://cbbi.udel.edu/wp-content/uploads/2017/01/Neuro.pdf)


### What coil should be used?

The protocol was designed for the 20 channels coil provided with the Siemens Vida. We also attempted to use the 64 channels coil, but the headset was too small for our patients population with spastic behavior, thus needing more space to fit their head around their neck as they often do not lay their head straight.

However, we initially maintained the protocol with both coils, so that this protocol can in fact rather easily be converted to a 64 channels coil. Most parameters can be set as exactly the same and just change the coil used from 20c to 64c in the Siemens syngo interface.

Beware however that although 64 channels coils provide a significant boost in SNR in the cortical areas, the wavelength is actually smaller and thus has a harder time penetrating through to subcortical areas. So if you are also interested in subcortical areas, you might want to stick with the 20c coil.

This paper might be of interest: Seidel, P., Levine, S. M., Tahedl, M., & Schwarzbach, J. V. (2019). Temporal signal-to-noise changes in combined multiband-and slice-accelerated echo-planar imaging with a 20-and 64-channel coil. *BioRxiv*, 641902.

### I can't find the FLAIR sequence on my machine!

If you are trying to reproduce the protocol from the printout, and thus search for native sequences from which to start tweaking to the same parameters of our printout, you will find that the FLAIR sequence is not available on Siemens machines. Instead, look for "dark fluid" sequences, which are exactly the same but have been renamed because of copyright issues on the name FLAIR. For more informations about the FLAIR/dark fluid sequence, please read the seminal paper: Hori, M., Okubo, T., Uozumi, K., Ishigame, K., Kumagai, H., & Araki, T. (2003). T1-weighted fluid-attenuated inversion recovery at low field strength: a viable alternative for T1-weighted intracranial imaging. *American journal of neuroradiology*, *24*(4), 648-651.