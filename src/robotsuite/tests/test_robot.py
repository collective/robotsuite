# -*- coding: utf-8 -*-
import unittest

from plone.app.testing import PLONE_ZSERVER
from plone.testing import layered

import robotsuite


def test_suite():
    suite = unittest.TestSuite()
    suite.addTests([
        layered(robotsuite.RobotTestSuite("test_plone_login.robot"),
                layer=PLONE_ZSERVER),
        robotsuite.RobotTestSuite("test_setups")
    ])
    return suite
