"""
For pytest
initialise a test database and profile
"""
from __future__ import absolute_import
import pytest

pytest_plugins = ['aiida.manage.tests.pytest_fixtures']  # pylint: disable=invalid-name
