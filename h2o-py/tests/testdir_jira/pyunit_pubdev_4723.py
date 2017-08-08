#!/usr/bin/env python
# -*- encoding: utf-8 -*-
from __future__ import absolute_import, division, print_function, unicode_literals

import h2o
from tests import pyunit_utils


def test_4723():
    frame = h2o.create_frame()
    frame['C1'].insert_missing_values(0.5)
    expected_rows_count = frame['C1'].shape[0]

    pandas_default_rows_count = frame['C1'].as_data_frame(use_pandas=True).shape[0]
    assert pandas_default_rows_count < expected_rows_count, "Result's rows count when using pandas with default strip_nas must be smaller than expected_rows_count. Expected: %s, actual: %s" % (
        expected_rows_count, pandas_default_rows_count)

    pandas_strip_rows_count = frame['C1'].as_data_frame(use_pandas=True, strip_nas=True).shape[0]
    assert pandas_strip_rows_count < expected_rows_count, "Result's rows count when using pandas with strip_nas=True must be smaller than expected_rows_count. Expected: %s, actual: %s" % (
        expected_rows_count, pandas_strip_rows_count)

    pandas_dont_strip_rows_count = frame['C1'].as_data_frame(use_pandas=True, strip_nas=False).shape[0]
    assert pandas_dont_strip_rows_count == expected_rows_count, "Result's rows count when using pandas with strip_nas=False must be equal than expected_rows_count. Expected: %s, actual: %s" % (
        expected_rows_count, pandas_dont_strip_rows_count)

    no_pandas_default_rows_count = len(frame['C1'].as_data_frame(use_pandas=False, header=False))
    assert no_pandas_default_rows_count == expected_rows_count, "Result's rows count when NOT using pandas with default strip_nas must be equal than expected_rows_count. Expected: %s, actual: %s" % (
        expected_rows_count, no_pandas_default_rows_count)

    no_pandas_strip_rows_count = len(frame['C1'].as_data_frame(use_pandas=False, header=False, strip_nas=True))
    assert no_pandas_strip_rows_count == expected_rows_count, "Result's rows count when NOT using pandas with strip_nas=True must be equal than expected_rows_count. Expected: %s, actual: %s" % (
        expected_rows_count, no_pandas_strip_rows_count)

    no_pandas_dont_strip_rows_count = len(frame['C1'].as_data_frame(use_pandas=False, header=False, strip_nas=False))
    assert no_pandas_dont_strip_rows_count == expected_rows_count, "Result's rows count when NOT using pandas with strip_nas=False must be equal than expected_rows_count. Expected: %s, actual: %s" % (
        expected_rows_count, no_pandas_dont_strip_rows_count)


if __name__ == "__main__":
    pyunit_utils.standalone_test(test_4723)
else:
    test_4723()
