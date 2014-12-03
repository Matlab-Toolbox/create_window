function [ result ] = create_window( window, fft_size, varargin )
%CREATE_WINDOW Create windows for application to data before applying fft.
%   Usage : 
%     w = create_window( window, fft_size)
%        window is one of 'rectangular', 'blackman'
%   
%   
%   w.window % window values for multiplication against data
%   w.incoherent_power_gain
%   w.coherent_power_gain
%
% Window Type recomendations from: http://www.ni.com/white-paper/4844/en/
% Hanning, General purpose, Sine wave or combination of sine waves, unknown
% content.
% Uniform, Broadband random noise, closely spaced sinewaves.
% Flat top, Accurate single tone amplitude measurements.

  if (nargin < 2)
    error('create_window:args Usage is create_window(window, fft_size)');
  end


  expectedWindow = {'rectangular','blackman','hanning','blackmanharris4','blackmanharris7'};
  if ( ~is_expected_string(window, expectedWindow) ) 
    s = cell_to_string( expectedWindow );
    error(['First parameter (window type) should be one of : ', s]);
  end

  
  if ( ~is_numeric_and_singular( fft_size ) )
    error(['Second parameter (fft_size) should be a single integer: ']);
  end

%% Window Implementations taken from:
% http://zone.ni.com/reference/en-XX/help/372058H-01/rfsapropref/pnirfsa_spectrum.fftwindowtype/
% http://en.wikipedia.org/wiki/Window_function
% http://uk.mathworks.com/help/signal/ref/blackmanharris.html
  
  a0 = 0;
  a1 = 0;
  a2 = 0;
  a3 = 0;
  a4 = 0;
  a5 = 0;
  a6 = 0;
  
  %% Decode Selection
  switch (window)
    case 'blackman'
      %result.window = blackman(fft_size);
      a0 = 0.42 ;
      a1 = 0.50 ;
      a2 = 0.08 ;
      
    case 'hanning'
      % result.window = hanning(fft_size);
      a0 = 0.50 ;
      a1 = 0.50 ;
      
     case 'hamming'
      % result.window = hanning(fft_size);
      a0 = 0.54 ;
      a1 = 0.46 ;

    case 'flat top'
      a0 = 0.215578948 ;
      a1 = 0.41663158  ;
      a2 = 0.277263158 ;
      a3 = 0.083578947 ;
      a4 = 0.006947368 ;

    case 'blackmanharris'
      a0 = 0.422323 ;
      a1 = 0.49755  ;
      a2 = 0.07922  ;
      
    case 'blackmanharris4' % 4 Term Blackman-Harris
      % result.window = blackmanharris(fft_size);
      a0 =	0.35875;
      a1 =	0.48829;
      a2 =	0.14128;
      a3 =	0.01168;
   
    case 'blackmanharris7' % 4 Term Blackman-Harris
      % Blackman Harris 7 Term
      a0 = 0.27105140069342;
      a1 = 0.43329793923448;
      a2 = 0.21812299954311;
      a3 = 0.06592544638803;
      a4 = 0.01081174209837;
      a5 = 0.00077658482522;
      a6 = 0.00001388721735;
      
        
  end
  

   if (window == 'rectangular')
     result.window = ones(fft_size, 1);
   else
     for i = 1:fft_size 
        w = (2*pi*i)/fft_size;
        result.window(i) = (a0 - a1*cos(w) + a2*cos(2*w) - a3*cos(3*w) + a4*cos(4*w) - a5*cos(5*w) + a6*cos(6*w));
      end
    end

    result.incoherent_power_gain = sum(result.window.^2);
    result.coherent_power_gain   = sum(result.window)^2 ;

    
    
    %% Embedded function
    function s = cell_to_string( dat )
      s = '';
      arr    = char( dat );
      [y,x] = size(arr);
      s = [arr(1,:)];
      for i = (2:y)
         s = [s, ', ', arr(i,:)];
      end
    end
    
    %% Custom Validations  
    function res = is_numeric_and_singular( x )
        res = isnumeric(x)& all(size(x) == [1,1]);
    end
  
  function res = is_expected_string( x, expectedString) 
     res = any(validatestring(x,expectedString));
  end
end

