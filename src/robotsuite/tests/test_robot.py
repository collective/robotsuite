# -*- coding: utf-8 -*-
import unittest

import robotsuite
from plone.app.testing import PLONE_ZSERVER
from plone.testing import layered


def test_suite():
    suite = unittest.TestSuite()
    suite.addTests([
        layered(robotsuite.RobotTestSuite("robot_plone_login.txt"),
                layer=PLONE_ZSERVER),
    ])
    return suite


class Keywords(object):
    """An example Robot Framework python keyword library"""

    def get_test_user_name(self):
        import plone.app.testing
        return plone.app.testing.interfaces.TEST_USER_NAME

    def get_test_user_password(self):
        import plone.app.testing
        return plone.app.testing.interfaces.TEST_USER_PASSWORD
