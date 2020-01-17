import pytest

from podcast_fetch_transcript.exceptions import McOperationNotFoundException, McMisconfiguredSpeechAPIException
from podcast_fetch_transcript.fetch_transcript import fetch_speech_api_transcripts


def test_fetch_speech_api_transcripts_invalid_id():
    """Try fetching transcript with an invalid Speech API operation ID."""
    with pytest.raises(McMisconfiguredSpeechAPIException, message="Fetch invalid transcript"):
        fetch_speech_api_transcripts(speech_operation_id='invalid')


def test_fetch_speech_api_transcripts_nonexistent_id():
    """Try fetching transcript with an nonexistent (although valid) Speech API operation ID."""
    with pytest.raises(McOperationNotFoundException, message="Fetch nonexistent transcript"):
        fetch_speech_api_transcripts(speech_operation_id='1234567890')
