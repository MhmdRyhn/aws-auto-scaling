activate_this = '/var/www/aws-auto-scaling/venv/bin/activate_this.py'
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))

import sys
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0, "/var/www/aws-auto-scaling/")

from project.main import app
application = app
