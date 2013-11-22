from setuptools import setup, find_packages

setup(
    name="robotsuite",
    version='1.4.2',
    description="Robot Framework test suite for Python unittest framework",
    long_description=(open("README.rst").read() + "\n" +
                      open("CHANGES.txt").read()),
    # Get more strings from
    # http://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        "Programming Language :: Python",
    ],
    keywords="",
    author="Asko Soukka",
    author_email="asko.soukka@iki.fi",
    url="https://github.com/collective/robotsuite/",
    license="GPL",
    packages=find_packages("src", exclude=["ez_setup"]),
    package_dir={"": "src"},
    namespace_packages=[],
    include_package_data=True,
    zip_safe=False,
    install_requires=[
        "setuptools",
        "unittest2",
        "robotframework>=2.8rc1",
        "lxml",
    ],
    extras_require={"test": [
        "plone.app.testing",
        "robotframework-selenium2library",
    ]}
)
