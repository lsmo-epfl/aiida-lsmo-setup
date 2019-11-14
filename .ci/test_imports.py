""" Tests for calculations

"""
from __future__ import absolute_import
import os
import io
import pytest

from aiida.plugins import DataFactory, CalculationFactory

NetworkCalculation = CalculationFactory('zeopp.network')
NetworkParameters = DataFactory('zeopp.parameters')
CifData = DataFactory('cif')
SinglefileData = DataFactory('singlefile')

def test_profile(aiida_profile):  # pylint: disable=unused-argument,invalid-name,invalid-name
    """Testing that we can create a profile"""
