function vl_demo_alldist
%

numRepetitions  = 3 ;
numDimensions   = 1000 ;
numSamplesRange = [300] ;

settingsRange = {{'alldist2', 'double',  'l2',         }, ...
                 {'alldist',  'double',  'l2', 'nosimd'}, ...
                 {'alldist',  'double',  'l2'          }, ...
                 {'alldist2', 'single',  'l2',         }, ...
                 {'alldist',  'single',  'l2', 'nosimd'}, ...
                 {'alldist',  'single',  'l2'          }, ...
                 {'alldist2', 'double',  'l1',         }, ...
                 {'alldist',  'double',  'l1', 'nosimd'}, ...
                 {'alldist',  'double',  'l1'          }, ...
                 {'alldist2', 'single',  'l1',         }, ...
                 {'alldist',  'single',  'l1', 'nosimd'}, ...
                 {'alldist',  'single',  'l1'          }, ...
                 {'alldist2', 'double',  'chi2',         }, ...
                 {'alldist',  'double',  'chi2', 'nosimd'}, ...
                 {'alldist',  'double',  'chi2'          }, ...
                 {'alldist2', 'single',  'chi2',         }, ...
                 {'alldist',  'single',  'chi2', 'nosimd'}, ...
                 {'alldist',  'single',  'chi2'          }, ...
                 {'alldist2', 'double',  'hell',         }, ...
                 {'alldist',  'double',  'hell', 'nosimd'}, ...
                 {'alldist',  'double',  'hell'          }, ...
                 {'alldist2', 'single',  'hell',         }, ...
                 {'alldist',  'single',  'hell', 'nosimd'}, ...
                 {'alldist',  'single',  'hell'          }, ...
                 {'alldist2', 'double',  'kl2',         }, ...
                 {'alldist',  'double',  'kl2', 'nosimd'}, ...
                 {'alldist',  'double',  'kl2'          }, ...
                 {'alldist2', 'single',  'kl2',         }, ...
                 {'alldist',  'single',  'kl2', 'nosimd'}, ...
                 {'alldist',  'single',  'kl2'          }, ...
                 {'alldist2', 'double',  'kl1',         }, ...
                 {'alldist',  'double',  'kl1', 'nosimd'}, ...
                 {'alldist',  'double',  'kl1'          }, ...
                 {'alldist2', 'single',  'kl1',         }, ...
                 {'alldist',  'single',  'kl1', 'nosimd'}, ...
                 {'alldist',  'single',  'kl1'          }, ...
                 {'alldist2', 'double',  'kchi2',         }, ...
                 {'alldist',  'double',  'kchi2', 'nosimd'}, ...
                 {'alldist',  'double',  'kchi2'          }, ...
                 {'alldist2', 'single',  'kchi2',         }, ...
                 {'alldist',  'single',  'kchi2', 'nosimd'}, ...
                 {'alldist',  'single',  'kchi2'          }, ...
                 {'alldist2', 'double',  'khell',         }, ...
                 {'alldist',  'double',  'khell', 'nosimd'}, ...
                 {'alldist',  'double',  'khell'          }, ...
                 {'alldist2', 'single',  'khell',         }, ...
                 {'alldist',  'single',  'khell', 'nosimd'}, ...
                 {'alldist',  'single',  'khell'          }, ...
                } ;

%settingsRange = settingsRange(end-5:end) ;

styles = {} ;
for marker={'x','+','.','*','o'}
  for color={'r','g','b','k','y'}
    styles{end+1} = {'color', char(color), 'marker', char(marker)} ;
  end
end

for ni=1:length(numSamplesRange)
  for ti=1:length(settingsRange)
    tocs = [] ;
    for ri=1:numRepetitions
      rand('state',ri) ;
      randn('state',ri) ;
      numSamples = numSamplesRange(ni) ;
      settings = settingsRange{ti} ;
      [tocs(end+1), D] = run_experiment(numDimensions, ...
                                        numSamples, ...
                                        settings) ;
    end
    means(ni,ti) = mean(tocs) ;
    stds(ni,ti)  = std(tocs) ;
    if mod(ti-1,3) == 0
      D0 = D ;
    else
      err = max(abs(D(:)-D0(:))) ;
      fprintf('err %f\n', err) ;
      if err > 1, keyboard ; end
    end
  end
end

if 0
  figure(1) ; clf ; hold on ;
  numStyles = length(styles) ;
  for ti=1:length(settingsRange)
    si = mod(ti - 1, numStyles) + 1 ;
    h(ti) = plot(numSamplesRange, means(:,ti), styles{si}{:}) ;
    leg{ti} = sprintf('%s ', settingsRange{ti}{:}) ;
    errorbar(numSamplesRange, means(:,ti), stds(:,ti), 'linestyle', 'none') ;
  end
end

for ti=1:length(settingsRange)
  leg{ti} = sprintf('%s ', settingsRange{ti}{:}) ;
end

figure(1) ; clf ;
barh(means(end,:)) ;
set(gca,'ytick', 1:length(leg), 'yticklabel', leg,'ydir','reverse') ;
xlabel('Time [s]') ;

function [elaps, D] = run_experiment(numDimensions, numSamples, settings)

distType  = 'l2' ;
algType   = 'alldist' ;
classType = 'double' ;
useSimd   = true ;

for si=1:length(settings)
  arg = settings{si} ;
  switch arg
    case {'l1', 'l2', 'chi2', 'hell', 'kl2', 'kl1', 'kchi2', 'khell'}
      distType = arg ;
    case {'alldist', 'alldist2'}
      algType = arg ;
    case {'single', 'double'}
      classType = arg ;
    case 'simd'
      useSimd = true ;
    case 'nosimd'
      useSimd = false ;
    otherwise
      assert(false) ;
  end
end

X = rand(numDimensions, numSamples) ;
X(X < .3) = 0 ;

switch classType
  case 'double'
  case 'single'
    X = single(X) ;
end

vl_simdctrl(double(useSimd)) ;

switch algType
  case 'alldist'
    tic ; D = vl_alldist(X, distType) ; elaps = toc ;
  case 'alldist2'
    tic ; D = vl_alldist2(X, distType) ; elaps = toc ;
end

