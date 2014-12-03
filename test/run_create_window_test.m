
  %% run_spec
  clear;
  

  %% For Functions
  %    Add function to path
  addpath('../function/');

  %% Test Vectors
  N = 4    ;
  test = {};
  test(end+1).type = 'rectangular'; test(end).expect = [1,1,1,1]';
  test(end+1).type = 'blackman';    test(end).expect = blackman(N);


  %% The tests
  error_count = 0;
  pass_count  = 0;

  for vector=1:size(test, 2)
    b           = create_window( test(vector).type, N );
    b.window
    if (  ~isequal(b.window, test(vector).expect )  )
      disp('create_window() Failed ')
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

