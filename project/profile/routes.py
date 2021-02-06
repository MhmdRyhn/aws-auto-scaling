"""
import os
from datetime import datetime

import boto3
import flask
from flask import Blueprint, request
from marshmallow.exceptions import ValidationError
from project.profile.schemas import ProfileSchema

profile_bp = Blueprint("profiles", __name__, url_prefix="/profiles")


@profile_bp.route("/", methods=["POST"], )
def create_profile(*args, **kwargs):
    # try:
    #     app_name = os.environ['app_name']
    #     environment = os.environ['environment']
    #     dynamodb_table_name = os.environ['dynamodb_table_name']
    # except KeyError as ex:
    #     return flask.jsonify({"error": 'Environment variable `{}` not set.'.format(str(ex))}), 400
    # resource = boto3.resource("dynamodb")
    # table = resource.Table('{}-{}-{}'.format(app_name, environment, dynamodb_table_name))
    data = request.get_json(force=True)
    try:
        data = ProfileSchema().load(data)
    except ValidationError as ex:
        return flask.jsonify({"error": str(ex)}), 400
    # response = table.put_item(
    #     Item={
    #         **data,
    #         'created_at': datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    #         'updated_at': datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    #     }
    # )
    return flask.jsonify({"info": "Profile created successfully"}), 201
"""
