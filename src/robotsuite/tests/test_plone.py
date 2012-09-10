# -*- coding: utf-8 -*-
"""Testing Plone using Robot Framework"""

import unittest

from plone.testing import layered

from plone.app.testing import PLONE_ZSERVER

import robotsuite


def test_suite():
    suite = unittest.TestSuite()
    suite.addTests([
        layered(robotsuite.RobotTestSuite("test_plone_login.txt"),
                layer=PLONE_ZSERVER),
    ])
    return suite


class Keywords(object):
    """Robot Framework keyword library"""

    def get_test_user_name(self):
        import plone.app.testing
        return plone.app.testing.interfaces.TEST_USER_NAME

    def get_test_user_password(self):
        import plone.app.testing
        return plone.app.testing.interfaces.TEST_USER_PASSWORD
