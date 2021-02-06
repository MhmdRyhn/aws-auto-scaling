import flask


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
    Doing a reasonably large calculation to imitate an actual operation.
    E.g., You can run a database query and then process the result.
    """
    summation = 0
    for i in range(10000000):
        summation += 1
    return flask.jsonify({"status": "SUCCESS", "summation": summation}), 200


@app.route("/health-check", methods=["GET"])
def health_check(*args, **kwargs):
    return flask.jsonify({"status": "HEALTHY"}), 200


if __name__ == '__main__':
    app.run(host="localhost", port=5000, debug=True)
