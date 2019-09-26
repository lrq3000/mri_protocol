Complementary informations & bibliography on GIGA-Consciousness MRI Protocol
============================================================================

New MRI Protocol for the MRI Siemens VIDA by the Coma Science Group, GIGA-Consciousness
First version 2018-06-19
Current version 52 on 2019-09-20

## Authors
This protocol was designed according to the state-of-the-art scientific litterature by Stephen Karl Larroque with help from Jean-Marc Léonard (Siemens Healthineers) and the CHU Liège MRI department.

## Description
This protocol was designed to offer the best quality and latest technologies (eg, MP2RAGE, FLAWS, 3shells DTI) while maintaining a low TA (Total Acquisition Time) below 30 minutes.

All choices are supported by the literature or specialized technical blog posts. All the references are mentioned below.

The protocol includes choices ("decisions" in Siemens terminology) to integrate additional information, such as whether the patient was sedated or not (the sequence name will be changed, and another localizer/scout will be done if necessary). As such, the protocol should never be modified during acquisition (except to redo a sequence), since all scenarios should already be integrated.

To ease the protocol application, the resting-state BOLD EPI is now done first, then structural is done, so that the subjects can sleep or be sedated with no impact on the data after the first 10 minutes. The BOLD is also separated in two: one sequence of 3min48 to be acquired without sedation as often as possible, and one of 6min13 that can be acquired with sedation. Indeed, the first (called "short") BOLD sequence is now the first sequence acquired, just after the localizer/scout. Thus, motion artifacts will be estimated by the MRI technologists on the "short" BOLD, and not on the structural anymore as was done before.

The protocol should be adaptable to any other machine as long as it has the required addons. It can be transfered from dicoms or from the exar file, or redone manually from the pdf.

This protocol was designed with a multi-domain approach in mind to reduce artifacts and manipulation time: the combination of a fmri BOLD fast enough to acquire even moving patients and the 3D MRI head pillow immobilizer (Pearltec Multi-PAD Kit) allow to acquire most patients without sedation. If sedation is still required for very uncollaborative patients, it should happen only after BOLD sequences, since BOLD is virtually unaffected by motion, and structural sequences (after BOLD) are unaffected by sedation.

## Requirements
Simultaneous Multi-Slice addon (SMS, aka multiband in other manufacturers) for BOLD, DTI and SWI accelerations. Caipirinha for FLAIR acceleration. GRAPPA parallel imaging acceleration for all (but might be replaceable by SENSE if necessary).

## Bibliography
	* slice order descending with distance factor for EPI (BOLD but NOT DTI): http://imaging.mrc-cbu.cam.ac.uk/imaging/CommonArtefacts#spinhistory and http://imaging.mrc-cbu.cam.ac.uk/imaging/TipsForDataAcquisition
	* with slice distance factor 20%/25%: https://www.mccauslandcenter.sc.edu/crnl/tools/stc and http://imaging.mrc-cbu.cam.ac.uk/imaging/TipsForDataAcquisition
	* (Unused but working): optimized T1 MPRAGE for Siemens 3T machines (tested but not used, replaced by MP2RAGE): https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4039442/ and https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4039442/
	* Enable 3D distortion correction: 3D distortion correction instead of 2D correction for DTI or none for bold (according to Siemens Healthineers this is always better than no correction, and probably better for coregistration and segmentation with T1. 2D distortion often enabled by default on default Siemens sequences and not 3D because most sequences are in 2D! Then we don't care about 3D correction. But in our case, where we do post-acquisition analysis, 3D correction is useful, and it's postprocessing, so it does not add any acquisition time nor SNR reduction). Also dynamic distortion correction for DTI = eddy correction, could be good but takes more time so disabled for now (can save both unfiltered images and corrected by checking the appropriate option).
	* (Unused but working): DIR SPACE WM suppressed FIR, as mask for segmentation (similar but not exactly like this paper): https://med.nyu.edu/radiology_research/sites/default/files/radiology_research/01328.pdf
	https://www.ncbi.nlm.nih.gov/pubmed/10232510
	https://www.ncbi.nlm.nih.gov/pubmed/7874427
	https://onlinelibrary.wiley.com/doi/abs/10.1002/mrm.22979
	* (Unused but working): DIR SPACE GM suppressed (WM mask): https://www.ncbi.nlm.nih.gov/pubmed/25213883
	* multiband s2p2 (factor x4) or s3p2 (factor 6) acceptable (for BOLD and DTI): https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4574400/ and https://practicalfmri.blogspot.com/2016/02/starting-points-for-sms-epi-at-3-t.html?m=1 and https://www.sciencedirect.com/science/article/pii/S1053811915007776?via%3Dihub and https://practicalfmri.blogspot.com/2016/12/use-of-split-slice-grappa-aka-leak.html
	https://practicalfmri.blogspot.com/2013/04/multiband-aka-simultaneous-multislice.html
	In fact we can go up to s4p2 with slight quality loss (but never go above GRAPPA p2 else too much Gibbs noise):
	    - Preibisch, Plos One, 2015
	    - Todd, NeuroImage, 2016
	    - Smith, 2018, 10.1016/j.mri.2018.06.013
	* Faster BOLD TR below 1.5s because better for HRF estimation and less motion noise:
	Note: below TR 1.5s is best to better estimate (and correct) HRF! (see following article + Daniele Marinazzo confirmed). And thus more statistical power (and less positives in regions influenced by physiological cardiac-induced noise = blood larger vessels, see Lund et al 2006 NeuroImage 29 54-66):
	Wu, G. R., & Marinazzo, D. (2016). Sensitivity of the resting-state haemodynamic response function estimation to autonomic nervous system fluctuations. Phil. Trans. R. Soc. A, 374(2067), 20150190.
	http://mriquestions.com/bold-pulse-sequences.html
	http://www.sbirc.ed.ac.uk/cyril/download/DTP_fMRI-preprocessing.pdf
	Importance of BOLD consistent parameters in cross-sectional studies of DMN: https://www.researchgate.net/publication/312320316_Test-Retest_Reproducibility_of_the_Intrinsic_Default_Mode_Network_Influence_of_fMRI_Slice-Order_Acquisition_and_Head-Motion_Correction_Methods
	* Potential differences between a sub-second BOLD results and more conventional BOLD with TR >= 2s is to be expected (and we observed them). This might be partially explained by:
	    - the HRF better estimated with a < 1.5s TR and thus having less influence on BOLD in this time resolution.
	    - anti-correlated networks will appear differently, since some of the anti-correlations might be due to the TR: the dynamics are much more fine-grained at sub-second time resolution than at 2s, thus anti-correlations might disappear and be replaced by correlations or no correlation at all, but new correlations might appear that were not visible before since the time window was too big to catch them. In other words, sub-second BOLD might allow to reveal middle-men that are usually hidden by anti-correlations that would have implied an indirect connection: now we can visualize them directly.
	* No PACE (prospective motion correction), because it prevents retrospective motion correction in post-processing: http://imaging.mrc-cbu.cam.ac.uk/imaging/TipsForDataAcquisition among others
	* Prescan Normalize important to increase contrast (and have way better coregistration, as proven by the paper on reducing flip angle/partial flip angle): https://practicalfmri.blogspot.com/2016/02/starting-points-for-sms-epi-at-3-t.html?m=1
	https://neurostars.org/t/advice-for-optimizing-subcortical-signal-with-phased-array-head-coils/1504/4
	https://practicalfmri.blogspot.com/2012/04/common-persistent-epi-artifacts-receive.html
	https://practicalfmri.blogspot.com/2013/07/12-channel-versus-32-channel-head-coils.html
	https://practicalfmri.blogspot.com/2012/11/review-using-bias-field-map-to-improve.html
	* Raw filter reduces truncation artifact/edge oscillation, but reduces high freq results, so disabled! (source is Siemens guy) https://books.google.be/books?id=rSU3CwAAQBAJ&pg=PA103&lpg=PA103&dq=peripheral+nerve+stimulation+fast+rf&source=bl&ots=dh7Ti_ZzAI&sig=y9ZMIOBCH6dC9l8ykIat-MwMKOE&hl=fr&sa=X&ved=2ahUKEwjtsIDzwLbcAhXBLFAKHf3wC2AQ6AEwC3oECAcQAQ#v=onepage&q=peripheral%20nerve%20stimulation%20fast%20rf&f=false and http://dev.clinical-mri.com.s166757.gridserver.com/wp-content/uploads/software_hardware_updates/Flash_52_HIDI_Bandwidth_13_03_19.pdf
	* fmri EPI BOLD had spatial filter enabled (gaussian filter) of 0.7mm on our old TR 2s protocol. This is now disabled to get more sharp images. To get the same result as before, just pre-smooth fmri BOLD images with 0.7mm Gaussian FWHM. This was done because we can always smooth afterward, but the opposite is not true: once it's smoothed by the machine, we can't get a sharper image. https://onlinelibrary.wiley.com/doi/pdf/10.1002/mrm.1910370514 and https://www.sciencedirect.com/science/article/pii/S1053811999904901
	* rf pulse type up to Normal or Fast or Fast* like before (will also reduce distortion susceptibility - because Low SAR no quality advantage it's only to reduce SAR), depends on SAR (Normal is OK in any case, Fast it depends)
	* receiver bandwidth increase to reduce metal, chemical and motion sensitivity (at a small SNR reduction expense): https://mrimaster.com/technique%20andwidth.html (and observed on our data)
	* halved optimal (Ernst) flip angle for better EPI BOLD contrast and lower SAR excitation and crosstalk (and thus artefacts) at a very small SNR reduction expense: http://dx.doi.org/10.1016/j.neuroimage.2012.10.076 and http://mriquestions.com/partial-flip-angles.html and https://practicalfmri.blogspot.com/2016/02/starting-points-for-sms-epi-at-3-t.html?m=1
	Code to calculate: thetas = math.asin(1/(lambdaa*snr0)) -> in radians, then convert to degrees, and can use this db for values (or values in the paper): http://www.mritoolbox.com/ParameterDatabase.html
	* 3shells DTI, in separate sequences without recalibration, using "Copy Reference" with "Adjustment" checked. 1 b700 30dir, 1 b1000 64dir high quality (low TE = 89ms), b2000 64 dir. Different TEs were used to speed up, but it's disadvised, but no other choice to keep in time constraints. This is analyzable with MRTRIX3 msmt_csd method (it officially supports different TEs in multishell), but might not work with other methods. Ref: http://community.mrtrix.org/t/good-b-value-sensitivity-parameter-for-2shell/1770
	* GRAPPA (iPAT parallel acquisition) is disadvised, but in practice works good for us so it's enabled: https://practicalfmri.blogspot.com/2016/02/starting-points-for-sms-epi-at-3-t.html?m=1 and  https://practicalfmri.blogspot.com/2012/03/grappa-another-warning-about-motion.html
	* ASL fast sequence default from Siemens, using 3D-GRASE with PASL-FAIR (Q2TIPS), it's called Perfusion Mode: FAIR QII https://www.healthcare.siemens.com/magnetic-resonance-imaging/options-and-upgrades/clinical-applications/asl
	Explanation of ASL-3D as implemented in Siemens: http://s434060124.online.de/aslindementiacms/basic-principles-of-asl-2
	* Enable PhoenixZip Report, so that all dicoms contain the protocol and can be installed on any other machine!
	* MP2RAGE replacing MPRAGE, auto-corrects inhomogeneities and better results in VBM and segmentation, particularly deep grey matter:
	https://www.ncbi.nlm.nih.gov/pubmed/19819338/
	https://figshare.com/articles/Morphometric_analyses_at_3T_and_7T_A_comparison_of_MPRAGE_and_MP2RAGE/1613502
	https://www.twitter.com/practicalfmri/status/958010551661092864
	https://www.youtube.com/watch?v=NGv4ZBye9PE
	https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4035370/
	https://w1.siemens.ch/home/ch/de/healthcare/produkte/acit/projects/pages/advanced-mp2rage.aspx
	MP2RAGE vs MEMPRAGE (advised by Freesurfer): https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4035370/ and http://www.theses.fr/2015REN1S035
	MEMP2RAGE, the future: http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0169265
	* FLAWS variant of MP2RAGE, to acquire simultaneously coregistered FGATIR (WMnull) and MPRAGE images, can then extract GM only image without any segmentation necessary! Ref: https://onlinelibrary.wiley.com/doi/abs/10.1002/jmri.23532
	* The protocol is compatible with the 20 channels antennae and the 64 channels antennae. The 64 channels antennae has more SNR, generating images looking more similar to 7T (with less contrast in deep brain structures and more on the outside, except if prescan normalize is enabled). It was decided that in our case, we would only study 20 channels antennae as the frame is big enough for spastic patient to place their heads inside (the 64 channels antennae has a very tiny frame! We can't even put a headphone, only earplugs).
	* Pearltec's Multi-Pad KIT, with a pression meter, is used to reduce further movements and reduce the likelihood of needing to sedate the patient.
	* Calculators: TI: http://www.seichokai.or.jp/fuchu/dept1603.php (ref: https://www.sciencedirect.com/science/article/pii/S0730725X13002312?via%3Dihub) Flip angle & T1 database: http://www.mritoolbox.com/ErnstAngle.html
	* Isotropic fmri and structural required (assumed) for SPM coregistration interpolation (source: somewhere in the manual or the wiki). Also, isotropic DTI is advised, as it allows for better noise correction and shell estimation (see MRTRIX or FSL docs).
	* Distortion correction of resting-state EPI BOLD using field maps is advised: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5717028/
	* To make FLAWS work with a good enough contrast, you need the TI to be low enough to nullify grey matter. To reduce MP2RAGE/FLAWS TI times, play with slice fourier interpolation and plane fourier interpolation. In our case, 7/8 was enough to attain 450 TI1 and 1350 TI2 (with slice fourier 6/8 we can go much lower). Although we derived our parameters by trial and error (as no mathematical or computational model currently models MP2RAGE two TIs interaction to optimize SNR, see below for calculators of single TIs), a recent paper advised FLAWS TI settings very close to ours: Wang, Y., Wang, Y., Zhang, Z., Xiong, Y., Zhang, Q., Yuan, C., & Guo, H. (2018). Segmentation of gray matter, white matter, and CSF with fluid and white matter suppression using MP2RAGE. Journal of Magnetic Resonance Imaging, 48(6), 1540-1550.
	* About DTI acceleration: the most gain in speed is attained through in-plane acceleration (GRAPPA) and slices acceleration (multiband/SMS). A factor of GRAPPA 2 ensures mostly unnoticeable parallelization noise (gibbs artifacts?), combined with a multiband factor of 2, for a total acceleration of 4. With a multiband factor of 3, (total acceleration factor of 6), there is slight but mostly unnoticeable decrease in quality in practice. If more acceleration is required, such as in clinical practice, the multiband factor can be increased to 4, combined with GRAPPA 2, for a total acceleration factor of 8. This produces noticeable noise due to multiband acceleration, but the tractography is mostly unmodified. Further gains can be made by tweaking the TR and TE. However, it is very important to reduce TE to get good quality, but need to balance with TR to get a low enough acquisition time. On our machine, we noticed a TE around 90 produced nice raw diffusion images. Play with plane & slice fourier interpolation and increase bandwidth to reduce TE. Then might try to increase TE a bit to see if TR can be decreased, play with these parameters until you obtain the lowest combination of TR and TE.
	* FLAIR acceleration: activate CAIPIHRINA, and use 2 in-plane acceleration (GRAPPA) combined with factor 3 slice acceleration (multiband). This should allow to halve the acquisition time without necessitating any change in the TR nor TI.
	* SWI: similar to FLAIR.
	* FLAIR with MTC option enabled reduces CSF motion artifacts: https://www.ncbi.nlm.nih.gov/pubmed/14523590
	* FLAIR with variable flip angle significantly increases SNR for white matter: https://onlinelibrary.wiley.com/doi/full/10.1002/jmri.24542
	* In the current protocol, we removed MoCo (retrospective motion correction) from BOLD and mosaics from DTI as they were generating too many additional files that were overloading our PACS server. They also are not necessary and can be reproduced post-hoc via softwares. You can however enable them if you have a PACS server that can support this amount of data (and the network has enough bandwidth to transfer that much data regularly).
	* Disable the spatial filter, which is simply a smoothing kernel, which can be applied post-hoc in any case. Indeed, this increases SNR at the expense of spatial resolution. If you still enable it, beware the filter value is in terms of frequency, so that 0.5 is a bigger smoothing kernel than 2.0.
	* Without a specialized 3D head immobilizer cushion, if using only pads, most motion is anterior-posterior and is not corrected:
	    - https://practicalfmri.blogspot.com/2012/05/common-intermittent-epi-artifacts.html#more
	    - https://practicalfmri.blogspot.com/2016/10/respiratory-oscillations-in-epi-and-sms.html
	    - https://twitter.com/practiCalfMRI/status/786312325963714560
	* Recent studies on the practical impact of multiband on fMRI EPI BOLD analyses:
	    - Smitha, K. A., Arun, K. M., Rajesh, P. G., Joel, S. E., Venkatesan, R., Thomas, B., & Kesavadas, C. (2018). Multiband fMRI as a plausible, time-saving technique for resting-state data acquisition: Study on functional connectivity mapping using graph theoretical measures. Magnetic resonance imaging, 53, 1-6.
	    - Uji, M., Wilson, R., Francis, S. T., Mullinger, K. J., & Mayhew, S. D. (2018). Exploring the advantages of multiband fMRI with simultaneous EEG to investigate coupling between gamma frequency neural activity and the BOLD response in humans. Human brain mapping, 39(4), 1673-1687.
	    - Risk, B. B., Kociuba, M. C., & Rowe, D. B. (2018). Impacts of simultaneous multislice acquisition on sensitivity and specificity in fMRI. NeuroImage, 172, 538-553.
	    - Demetriou, L., Kowalczyk, O. S., Tyson, G., Bello, T., Newbould, R. D., & Wall, M. B. (2016). A comprehensive evaluation of multiband-accelerated sequences and their effects on statistical outcome measures in fMRI. BioRxiv, 076307.
	    - Bhandari, R., Gazzola, V., & Keysers, C. (2019). Challenges in assessing voxel-wise single-subject level benefits of MB acceleration. bioRxiv, 756361.
	* Multband + Parallel Imaging (here Sense, in our case GRAPPA): http://clinical.netforum.healthcare.philips.com/global/Explore/White-Papers/MRI/MultiBand-SENSE-widens-possibilities-for-fMRI-and-dMRI-in-brain

## FUTURE
    * Synthetic MRI as an extension of FLAWS: SyMRI software and QRAPMASTER sequence:
        - Gonçalves, F. G., Serai, S. D., & Zuccoli, G. (2018). Synthetic brain MRI: review of current concepts and future directions. Topics in Magnetic Resonance Imaging, 27(6), 387-393.
        - SyMRI concrete implementation: https://www.syntheticmr.com/products/symri-neuro/
        - Available since August 2019 on Siemens machines: https://www.syntheticmr.com/archive/articles/symri-neuro-is-now-available-in-syngo-via-open-apps-from-siemens-healthineers-in-the-us/
        - Limitations: https://mriquestions.com/synthetic-mri.html
        - Siemens version: MR Fingerprinting, can overcome some of the limitations (eg, can acquire FLAIR) and has some additional advantages (less motion sensitive): https://static.healthcare.siemens.com/siemens_hwem-hwem_ssxa_websites-context-root/wcm/idc/groups/public/@global/@imaging/@mri/documents/download/mda2/mdky/~edisp/editorial_65-03045718.pdf and https://www.healthcare.siemens.com/magnetic-resonance-imaging/magnetom-world/hot-topics/mr-fingerprinting
    * Artifial intelligence reconstruction, AUTOMAP: Zhu, B., Liu, J. Z., Cauley, S. F., Rosen, B. R., & Rosen, M. S. (2018). Image reconstruction by domain-transform manifold learning. Nature, 555(7697), 487. https://www.itnonline.com/content/artificial-intelligence-provides-faster-clearer-mri-scans
    * Multi-Echo BOLD with ME-ICA for unsupervised noise correction of all confounds: Multi-Echo BOLD is the functional equivalent for denoising akin to FLAW for structural segmentation. Indeed, ME BOLD combined with ME-ICA technique can denoise neuronal components from non-neuronal components, in other word noise, in a totally unsupervised way using additional info from NMR relaxation. The combination of Multi-Echo BOLD with FLAW is a promising venue to significantly increase MRI analysis standardization (ref paper with hundreds of mri pipeline, basically each paper its own) and quality, by decreasing reliance on computer algorithms such as segmentation or denoising which can lead to very different results, but rather rely on additional physical tissues information from the MRI acquisition.
    * Reverse phase encoding (FSL Eddy documentation webpage). Our protocol is too much time constrained to allow for both reverse phase encoding and multi-shell. Maybe by just reversing the phase of one of the shells?
    * Read-out segmented DTI and fMRI such as DTI Resolve:
        - http://mriquestions.com/readout-segmented-dwi.html    
        - https://static.healthcare.siemens.com/siemens_hwem-hwem_ssxa_websites-context-root/wcm/idc/groups/public/@global/@imaging/@mri/documents/download/mdax/mzc0/~edisp/mr_app_resolve_final_121991554_1-00678917.pdf
        - https://onlinelibrary.wiley.com/doi/abs/10.1002/ima.22179
        - Wang, Y., Ma, X., Zhang, Z., Dai, E., Jeong, H. K., Xie, B., ... & Guo, H. (2018). A comparison of readout segmented EPI and interleaved EPI in high-resolution diffusion weighted imaging. Magnetic resonance imaging, 47, 39-47.
        * future of fast acquisition: WAVE-CAIPI, EPTI = BOLD just 10x slower than EEG (~30ms) but volumetric still in work as of 2018, submilimeter DTI and gSlider-SMS for GM fibers analysis (U-Fibers connecting adjacent gyri make up more brain volume than long-range fibers! Schuez & Miller CRC 2003 + Song et al, Brain Connectivity, 2014).
        * The following talk explains why acceleration can reduce EPI distortion and blurring: https://www.healthcare.siemens.com/magnetic-resonance-imaging/magnetom-world/clinical-corner/clinical-talks/advances-in-rapid-neuro-mri.html
    * Alternative to FLAWS if you don't have MP2RAGE but have FLAIR and T2: FLAIR2 = 3D-FLAIR .* 3D-T2 ; Contrary to FLAWS the images are not necessarily coregistered but it offers CSF nullification and increased WM vs GM contrast compared to DIR (double inversion recovery): https://www.researchgate.net/publication/282702583_FLAIR2_A_combination_of_FLAIR_and_T2_for_improved_MS_lesion_detection
    * Blipped Caipirinha, unavailable at the time the protocol was designed but very promising to reduce noise while still accelerating acquisition: https://static.healthcare.siemens.com/siemens_hwem-hwem_ssxa_websites-context-root/wcm/idc/groups/public/@global/@imaging/@mri/documents/download/mdaw/mtix/~edisp/controlled_aliasing_in_parallel_imaging_results_caipirinha-00124408.pdf
    * Compressed sensing: https://www.youtube.com/watch?v=s0TDHYFDn68



## Protocol walkthrough

LATEST PROTOCOL: Head > Coma > Coma Science Group > Coma 20c
1. AAhead_scout
2. Decision: Patient anesthetized?
Yes: ep2d_bold_repos_moco_s3_p2_long_avec_AG
No: ep2d_bold_repos_moco_s3_p2_long_sans_AG
3. gre_field_mapping
4. t1_mp2rage_sag_p2_iso_FLAWS_fast
5. ep2d_diff_mddw_30_p2_s4_b700
6. ep2d_diff_mddw_64_p2_s4_b1000_DO_NOT_READJUST
7. ep2d_diff_mddw_64_p2_s4_b2000_DO_NOT_READJUST
8. t2_space_FLAIR_sag_p3_iso
9. t2_swi_tra_p2s2_ir_2mm
10. Decision: Acquire PC-ASL?
    - If yes, is patient intubed? (this can change oxygenation and thus must be accounted for in analyses):
      Yes: pcasl_3d_tra_p2_iso_3mm_highres_fast_withintub
      No: pcasl_3d_tra_p2_iso_3mm_highres_fast_nointub
11. Optional: t2_tse_tra_512_p2
12. Optional: t1_mp2rage_sag_p2_iso_fast

Explanation:
* A scout is acquired for the machine to orient the coils to the subject's head (14s). AAHead stands for automatical alignment:
    - Chen, T., Zhan, Y., Zhang, S., & Dewan, M. (2011, September). Automatic alignment of brain MR scout scans using data-adaptive multi-structural model. In International Conference on Medical Image Computing and Computer-Assisted Intervention (pp. 574-581). Springer, Berlin, Heidelberg.
    - van der Kouwe, A. J., Benner, T., Fischl, B., Schmitt, F., Salat, D. H., Harder, M., ... & Dale, A. M. (2005). On-line automatic slice positioning for brain MR imaging. Neuroimage, 27(1), 222-230.
    - https://www.siemens-healthineers.com/magnetic-resonance-imaging/options-and-upgrades/clinical-applications/autoalign
    
* First we begin with a BOLD of 6min13 (500 volumes, TR 728ms). We do so to factor in that patient will tend to stress and move more as time passes, or to fall asleep. If possible, this is acquired without sedation (motion should NOT be a factor since the sequence is super fast, but if patient is moving too much for his own security then sedation is usually required...). Remember: motion is correctable with fmri, but NOT sedation. Prefer always to avoid sedation whenever possible.

* A fieldmap is acquired (57s). From this step onward, patient might be sedated with no negligible impact on the acquisition, as it should have little to no influence on the subsequent structural sequences.

* MP2RAGE FLAWS (structural) is acquired (5:02min). Experimental sequence that acquires 2 images simultaneously and perfectly coregistered: a MPRAGE (FLAWS_INV2) image, a GMnull (FLAWS_INV1) image and a white matter mask (FLAWS_UNI with GMnull and CSFnull) image. By computing min(i1, i2), we get the GM segmentation (ie, WMnull and CSFnull), which allow for perfect coregistration. An alternative to get better SNR is to use the original equation from MP2RAGE to combine INV1 and INV2 images by calculating in imcalc: i1 .* i2

* 3shells DTI is acquired with b700, b1000 and b2000 (13:25min). Analysis can use only b1000 (exactly same sequence as before) or use all 3 b-vallues by using MRTRIX.

* Clinical sequences are acquired (FLAIR, SWI) (6:12min).

* Static high-resolution PC-ASL consisting of 4 images merged into a perfusion-weighted image (2:17min).

  Total acquisition time: 28:07 without PC-ASL ; 30:24 with PC-ASL.

Optional sequences that can be added (available on the printout and the exar1 file):
* T2 TSE
* A MP2RAGE (structural) is acquired (5min). Use MP2RAGE_UNI (combination of INV1 and INV2 images, this eliminates B0 and B1 inhomogeneities)

## Acquisition instructions

Always instruct the subjects/patients to stay the eyes closed. The best would be to write down whether the subjects/patients had their eyes open/closed, but this might prove fruitless with spastic and DOC patients.

When exporting the DICOMs, prefer to use Enhanced DICOMS format if possible, as this saves up space. This file format is readable with pydicom, RadiAnt DICOM Viewer, dcm2niix and MRIConvert.
