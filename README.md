# SCDsim

## SCDsim/TestBench.m: 
Run the simulation compare the floating point and fixed point. 

  Parameters:
  
              bit: store the worldlength of each block. 
              Type: 'FAM' or 'SSCA' to simulate in FAM or SSCA method. 
              
  Functions:
  
              autofamFixedv3.m: run the FAM method in fixed point
                            input:
                                   x: input column vector 
                                   fs: sampling rate
                                   df: desired frequency resolution 
                                   dalpha: desired cyclic frequency resolution
                                   bitInput: worldlength of each block
                            output: 
                                   SX: spectral correlation density function estimate
                                   alphao: cyclic frequency
                                   fo: spectrum frequency
                                   result: output of each block with normalization factors
              autofamv3.m:run the FAM method in floating point
                         input:
                                same as autofamFixedv3.m
                                scale: normalization factors of each block
              autosscaFixedNormv3.m: run the SSCA method in fixed point
              autosscaSingleNormv3.m: run the SSCA method in floating point
              FFTFixedv3.m: compute the FFT in fixed point
              FFTFloatv3.m: compute the FFT in floating point
              printResult.m: print and compare the SQNR for simulation and theory
## SCDsim/Plotresult.m
Plot the simulation result with theory result and there errors in SQNR
![FAMvsSSCA](https://user-images.githubusercontent.com/33167403/110423249-d3e04d00-80f4-11eb-808f-6fb40801fc63.jpg)
![ErrorsofSimandTheory](https://user-images.githubusercontent.com/33167403/110276177-b5ac1b80-8026-11eb-8acd-302c61dab12a.jpg)


## SCDsim/TestCheckResult.m
Pareto Optimal 
![CandSQNR](https://user-images.githubusercontent.com/33167403/110276255-dbd1bb80-8026-11eb-8e7b-7493255907c3.jpg)
