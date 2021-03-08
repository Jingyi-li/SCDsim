# SCDsim

SCDsim/TestBentch.m: Run the simulation compare the floating point and fixed point. 
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
                            output: 
                                   SX: spectral correlation density function estimate
                                   alphao: cyclic frequency
                                   fo: spectrum frequency
                                   result: output of each block with normalization factors
              autofamv3.m:run the FAM method in floating point
              autosscaFixedNormv3.m: run the SSCA method in fixed point
              autosscaSingleNormv3.m: run the SSCA method in floating point
              
              
