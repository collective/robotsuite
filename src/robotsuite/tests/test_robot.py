# -*- coding: utf-8 -*-
import unittest
import robotsuite


def test_suite():
    suite = unittest.TestSuite()
    suite.addTests([
        robotsuite.RobotTestSuite('test_robot.robot'),
        robotsuite.RobotTestSuite('test_setups')
    ])
    return suite
