# Demo

This sample code implements task available [here](https://gist.github.com/mike-wegrzyn/f2d63bef963390e97089e35e6ee09caa)

## Tech Stack
- Python3.9
- Robot Framework with Selenium Library

## Preconditions:
It is expected, that machine has preinstalled:
- Python3.9
- Chrome Browser 104.X+

All other dependencies will be automatically downloaded and isolated in the virtual env while running tests.

## Test Run
Windows:  
`python run_all_tests.py`  
*<sub>Note: Assuming that python is added to the `$PATH` and points to Python3.9 installation</sub>*

Linux/Mac  
`python3 run_all_tests.py`  
*<sub>Note: Assuming that python3 is added to the `$PATH` and points to Python3.9 installation</sub>*  
*<sub>Note: Mac path is not tested</sub>*

## Result
Test run will generate report in the terminal as well as produce `report.html` file