"""
from marshmallow import Schema, EXCLUDE
from marshmallow.fields import Str
from marshmallow.validate import Length


class ProfileSchema(Schema):
    username = Str(required=True, validate=[Length(min=1, max=16)])
    full_name = Str(required=True)
    personal_address = Str(required=True)
    profession = Str(required=True)
    institution = Str(required=True)
    institution_address = Str(required=True)

    class Meta:
        unknown = EXCLUDE
"""
