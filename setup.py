from setuptools import setup, find_packages

version = "0.4.0"

requires=[
    "setuptools",
    "unittest2",
    "robotframework>=2.7.1",
    ]

setup(name="robotsuite",
      version=version,
      description="Robot Framework test suite for Python unittest framework",
      long_description=open("README.rst").read() + "\n" +
                       open("HISTORY.txt").read(),
      # Get more strings from
      # http://pypi.python.org/pypi?%3Aaction=list_classifiers
      classifiers=[
          "Programming Language :: Python",
      ],
      keywords="",
      author="Asko Soukka",
      author_email="asko.soukka@iki.fi",
      url="https://github.com/datakurre/robotsuite/",
      license="GPL",
      packages=find_packages("src", exclude=["ez_setup"]),
      package_dir={"": "src"},
      namespace_packages=[],
      include_package_data=True,
      zip_safe=False,
      install_requires=requires,
      extras_require={
      },
      entry_points="""
      """
      )
