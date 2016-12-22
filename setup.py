import sys
from setuptools import setup, find_packages

PY3 = sys.version_info[0] == 3

install_requires = [
    'six',
    'setuptools',
    'lxml'
]

if PY3:
    install_requires.append('robotframework-python3>=2.8rc1')
else:
    install_requires.extend(['robotframework>=2.8rc1', ])

setup(
    name='robotsuite',
    version='2.0.0',
    description='Robot Framework test suite for Python unittest framework',
    long_description=(open('README.rst').read() + '\n' +
                      open('CHANGES.txt').read()),
    # Get more strings from
    # http://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        'Programming Language :: Python',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3.4',
    ],
    keywords='',
    author='Asko Soukka',
    author_email='asko.soukka@iki.fi',
    url='https://github.com/collective/robotsuite/',
    license='GPL',
    packages=find_packages('src', exclude=['ez_setup']),
    package_dir={'': 'src'},
    namespace_packages=[],
    include_package_data=True,
    zip_safe=False,
    install_requires=install_requires,
    extras_require={'test': [
    ]}
)
