import flask
from ec2_metadata import ec2_metadata


# from project.profile.routes import profile_bp


def _create_app():
    """ Flask App Entry Point """
    flask_app = flask.Flask(__name__)

    # Registers Blueprints
    # flask_app.register_blueprint(profile_bp)

    @flask_app.errorhandler(404)
    def page_not_found(error):
        """
        Handles 404 error
        :return: error message
        """
        return flask.jsonify({"error": "Resource not found"}), 404

    @flask_app.errorhandler(500)
    def internal_server_error(error):
        """
        Handles 500 error
        :return: error message
        """
        return flask.jsonify({"error": "Internal server error"}), 500

    return flask_app


app = _create_app()


@app.route("/", methods=["GET"])
def calculation(*args, **kwargs):
    """
    Should do a reasonably large calculation to imitate an actual operation.
    E.g., You can run a database query and then process the result.
    """
    try:
        instance_id = ec2_metadata.instance_id
        private_ip = ec2_metadata.private_ipv4
        public_ip = ec2_metadata.public_ipv4
        instance_type = ec2_metadata.instance_type
        return flask.jsonify({
            "status": "SUCCESS",
            "instance_info": {
                "instance_id": instance_id,
                "private_ip": private_ip,
                "public_ip": public_ip,
                "instance_type": instance_type
            }
        }), 200
    except Exception:
        return flask.jsonify({
            "status": "FAILED",
            "instance_info": "Not an EC2 instance or the instance doesn't have enough permission."
        }), 200


@app.route("/health-check", methods=["GET"])
def health_check(*args, **kwargs):
    return flask.jsonify({"status": "HEALTHY"}), 200


if __name__ == '__main__':
    app.run(host="localhost", port=5000, debug=True)
