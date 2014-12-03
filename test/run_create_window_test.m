
  %% run_spec
  clear;
  %% Clear import list to test correct library
  clear import; 

  %% For Packages
  %    Add package to path (+function folder must be on path)
  addpath('../package/');

  %    Import functions 
  import padarray_pkg.* 

  %% For Functions
  %    Add function to path
  addpath('../function/');

  %% Test Vectors
  test = {};
  test(end+1).input = 0; test(end).expect = '0';
  test(end+1).input = 1; test(end).expect = '1';


  %% The tests
  error_count = 0;
  pass_count  = 0;

  for vector=1:size(test, 2)
    b           = create_window(i test(vector).input );
    if (  ~isequal(b, test(vector).expect )  )
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

