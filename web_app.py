from flask import Flask, request, render_template
from datetime import datetime
import os

app = Flask(__name__)

if not os.path.exists("logs"):
    os.makedirs("logs")

@app.route("/",methods=["GET","POST"])
def hello():
    ip = request.remote_addr  # Get visitor IP
    name=None
    log_path = "logs/visits.log"

    if request.method == "POST":
        name = request.form.get("name")
        with open(log_path, "a") as file:
            name = request.form.get("name")
            file.write(f"Visit by {name} from {ip} at {datetime.now()}\n")  
    return render_template("index.html", ip=ip, visit_time=datetime.now(), name=name)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)