#!/usr/bin/env python

from setuptools import setup  # type: ignore

setup(
    name="xontrib-simplejump",
    version="0.6.0",
    license="EUPL-1.2",
    author="Médéric Hurier",
    author_email="dev@fmind.me",
    long_description_content_type="text/markdown",
    long_description=open("README.md", "r").read(),
    description="The simplest way to jump between directories.",
    url="https://git.fmind.me/fmind/xontrib-simplejump",
    keywords="xontrib autojump directory",
    classifiers=[
        "Topic :: Utilities",
        "Environment :: Console",
        "Operating System :: POSIX",
        "Natural Language :: English",
        "Intended Audience :: Developers",
        "Development Status :: 3 - Alpha",
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: European Union Public Licence 1.2 (EUPL 1.2)",
    ],
    extras_require={"dist": ["twine", "wheel", "setuptools"]},
    python_requires=">=3.6",
    install_requires=["xonsh"],
    packages=["xontrib"],
    package_dir={"xontrib": "xontrib"},
    package_data={"xontrib": ["*.xsh"]},
)
