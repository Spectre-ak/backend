#!/usr/bin/env py.test

from mediawords.dbi.downloads.store import get_media_id
from mediawords.dbi.downloads.setup_test_downloads import TestDownloadsDB


class TestGetMediaID(TestDownloadsDB):
    """Run tests that require database access."""

    def test_get_media_id(self):
        media_id = get_media_id(db=self.__db, download=self.test_download)
        assert media_id == self.test_medium['media_id']
