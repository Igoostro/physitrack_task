import subprocess
import sys
import os
from abc import ABC, abstractmethod

REQUIREMENTS_FILE_NAME  = 'requirements.txt'
VENV_DIR                = '.venv'
BROWSER_CHROME          = 'chrome'

class OsController(ABC):
    @abstractmethod
    def get_cmd_list(self):
        pass

    @abstractmethod
    def get_python(self):
        pass
    
    @abstractmethod
    def get_webdrivermanager_os(self):
        pass

class WindowsController(OsController):
    def __init__(self, venv_dir):
        self.venv_dir = venv_dir

    def get_cmd_list(self):
        return ['.venv\\Scripts\\activate.bat', '&', 'python', '-m', 'robot', '--variable', f'G_RESOURCES:{os.getcwd()}\\resources', 'tests\\', '&', 'deactivate']

    def get_python(self):
        return f'{self.venv_dir}\\Scripts\\python.exe'

    def get_webdrivermanager_os(self):
        return 'win'

class LinuxController(OsController):
    def __init__(self, venv_dir):
        self.venv_dir = venv_dir

    def get_cmd_list(self):
        ['.venv/bin/activate', '&', 'python', '-m', 'robot', '--variable', f'G_RESOURCES:{os.getcwd()}/resources', 'tests/', '&', 'deactivate']

    def get_python(self):
        return f'{self.venv_dir}/bin/python'

    def get_webdrivermanager_os(self):
        return 'linux'

class MacController(LinuxController):
    def __init__(self, venv_dir):
        super().__init__(self, venv_dir)

    def get_webdrivermanager_os(self):
        return 'mac'

class OsControllerFactory:
    @staticmethod
    def create(platform, venv_dir):
        if platform.startswith('win'):
            print("Detected windows platform")
            return WindowsController(venv_dir)
        if platform.startswith('linux'):
            print("Detected linux platform")
            return LinuxController(venv_dir)
        if platform.startswith('darwin'):
            print("Detected mac platform")
            return MacController(venv_dir)

        raise RuntimeError(f'Unsupported platform: {platform}')


def is_cwd_ok():
    return os.path.isfile(REQUIREMENTS_FILE_NAME) and os.path.isfile(__file__)

def install_dependencies(python_path, requirements_file):
    subprocess.check_call([python_path, '-m', 'pip', 'install', '-r', requirements_file])

def is_venv_created(venv_dir):
    return os.path.isdir(venv_dir)

def create_venv(venv_dir):
    subprocess.check_call([sys.executable, '-m', 'venv', venv_dir])
    print('.venv created!')

def install_webdriver(python_path, os, browser):
    subprocess.check_call([python_path, '-m', 'webdrivermanager', '--os', os, browser])
    print(f'{browser} webdriver for {os} installed!')

if __name__ == "__main__":
    os_controller = OsControllerFactory.create(sys.platform, VENV_DIR)

    if not is_cwd_ok():
        print('Error! Execute script from the project root dir')
        os.abort()

    if not is_venv_created(VENV_DIR):
        create_venv(VENV_DIR)
    install_dependencies(os_controller.get_python(), REQUIREMENTS_FILE_NAME)
    install_webdriver(os_controller.get_python(), os_controller.get_webdrivermanager_os(), BROWSER_CHROME)

    run_cmd = os_controller.get_cmd_list()
    subprocess.check_call(run_cmd)

    print('Finished!')