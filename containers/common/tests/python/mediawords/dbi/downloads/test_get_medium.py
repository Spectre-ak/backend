#!/usr/bin/env py.test

from mediawords.dbi.downloads.store import get_medium
from mediawords.dbi.downloads.setup_test_downloads import TestDownloadsDB


class TestGetMedium(TestDownloadsDB):
    """Run tests that require database access."""

    def test_get_medium(self):
        medium = get_medium(db=self.__db, download=self.test_download)
        assert medium == self.test_medium
