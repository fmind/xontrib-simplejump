#!/usr/bin/env python

try:
    from setuptools import setup  # type: ignore
except ImportError:
    from distutils.core import setup

setup(
    name="xontrib-simplejump",
    version="0.5.0",
    license="EUPL-1.2",
    author="Médéric Hurier",
    author_email="dev@fmind.me",
    url="https://git.fmind.me/fmind/xontrib-simplejump",
    description="The simplest way to jump between directories.",
    platforms=["POSIX"],
    packages=["xontrib"],
    package_dir={"xontrib": "xontrib"},
    package_data={"xontrib": ["*.xsh"]},
)
