
  %% run_spec
  clear;
  

  %% For Functions
  %    Add function to path
  addpath('../function/');

  
 % floating_point_tol = 1e-15;
  tol = 1e-15;
  isequalAbs = @(x,y) ( all(abs(x-y) <= tol ));
  
  %% Test metrics
  error_count = 0;
  pass_count  = 0;
  
  % Precalculated expected values
  HAMMING.coherent_gain = 0.54;
  HAMMING.EQNB          = 1.36 ;
  
  %% Test Vectors
  N = 8    ;
  test = {};
  test(end+1).type = 'rectangular';      test(end).expect = ones(N,1);
  test(end+1).type = 'blackman';         test(end).expect = blackman(N);
  test(end+1).type = 'blackmanharris4';  test(end).expect = blackmanharris(N);
  test(end+1).type = 'hamming';          test(end).expect = hamming(N);
  test(end+1).type = 'hanning';          test(end).expect = hann(N);
  test(end+1).type = 'flat top';         test(end).expect = flattopwin(N);


  % The tests 
  for vector=1:size(test, 2)
    b           = create_window( test(vector).type, N );
    b.window;
    % Check if equl with in a given tolerance
    if (  ~isequalAbs(b.window, test(vector).expect )  ) 
      disp(['create_window(', test(vector).type,  ') Failed '])
      disp('    Result  : Expected')
      disp([b.window'; test(vector).expect']')
      error_count = error_count + 1;
    else
      pass_count  = pass_count  + 1;
    end
  end
  
  
  %% Large N (128)
  N = 128    ;
  test = {};
  test(end+1).type = 'rectangular';      test(end).expect = ones(N,1);
  test(end+1).type = 'blackman';         test(end).expect = blackman(N);
  test(end+1).type = 'blackmanharris4';  test(end).expect = blackmanharris(N);
  test(end+1).type = 'hamming';          test(end).expect = hamming(N);
  test(end+1).type = 'hanning';          test(end).expect = hann(N);

  % The tests 
  for vector=1:size(test, 2)
    b           = create_window( test(vector).type, N );
    b.window;
    % Check if equl with in a given tolerance
    if (  ~isequalAbs(b.window, test(vector).expect )  ) 
      disp(['create_window(', test(vector).type,  ') Failed '])
      error_count = error_count + 1;
    else
      pass_count  = pass_count  + 1;
    end
  end

  
  
  
  
  %% Test Status Report
  if error_count > 0
    disp(['Test FAILED : ', num2str(pass_count), ' passes and ',num2str(error_count),' fails'])
  else
    disp(['Test Passed : ', num2str(pass_count), ' checks ran '])
  end


