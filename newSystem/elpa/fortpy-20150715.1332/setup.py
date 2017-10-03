try:
    from setuptools import setup
    args = {}
except ImportError:
    from distutils.core import setup
    args = dict(scripts=['fortpyepcserver.py'])
    print("""\
*** WARNING: setuptools is not found.  Using distutils...
It is highly recommended to install Fortpy.el via M-x fortpy:install-server.
Note: If you are using Windows, then Fortpy.el will not work with distutils.
""")

setup(
    name='fortpyepcserver',
    py_modules=['fortpyepcserver'],
    install_requires=[
        "fortpy>=1.1.1",
        "epc>=0.0.4",
        "argparse",
    ],
    entry_points={
        'console_scripts': ['fortpyepcserver = fortpyepcserver:main'],
    },
    **args
)
