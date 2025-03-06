# -*- coding: utf-8 -*-
import os
import robotsuite
import unittest


def test_suite():
    os.environ["ROBOT_MYVAR1"] = "FOOBAR"
    os.environ["ROBOT_MYVAR2"] = "ÅÄÖ"
    suite = unittest.TestSuite()
    suite.addTests(
        [
            robotsuite.RobotTestSuite("test_example.robot", retry_count=3),
            robotsuite.RobotTestSuite("test_variables.robot"),
            robotsuite.RobotTestSuite("test_setups"),
        ]
    )
    return suite
