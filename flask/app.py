from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
import boto3
import os

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# S3 Configuration
try:
    s3 = boto3.client('s3')
except Exception:
    s3 = None

BUCKET_NAME = 'my-todo-backup-bucket-294069345983-eu-north-1-an'


# Database Model
class Todo(db.Model):

    id = db.Column(db.Integer, primary_key=True)

    title = db.Column(
        db.String(200),
        nullable=False
    )

    due_date = db.Column(
        db.String(50),
        nullable=False
    )


# Create Database
with app.app_context():
    db.create_all()


# Backup Function
def backup_database():

    try:

        if s3 is None:
            print("S3 not configured locally")
            return

        db_path = os.path.join(
            app.instance_path,
            'database.db'
        )

        s3.upload_file(
            db_path,
            BUCKET_NAME,
            'database_backup.db'
        )

        print("Backup uploaded to S3 successfully")

    except Exception as e:

        print("Backup skipped:", e)


# Home Route
@app.route('/', methods=['GET', 'POST'])
def index():

    if request.method == 'POST':

        title = request.form.get('title')
        due_date = request.form.get('due_date')

        if title and due_date:

            todo = Todo(
                title=title,
                due_date=due_date
            )

            db.session.add(todo)
            db.session.commit()

            # Backup after adding task
            backup_database()

        return redirect(url_for('index'))

    todos = Todo.query.order_by(Todo.id.desc()).all()

    return render_template(
        'index.html',
        todos=todos
    )


# Edit Route
@app.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit(id):

    todo = Todo.query.get_or_404(id)

    if request.method == 'POST':

        todo.title = request.form.get('title')
        todo.due_date = request.form.get('due_date')

        db.session.commit()

        # Backup after editing task
        backup_database()

        return redirect(url_for('index'))

    return render_template(
        'edit.html',
        todo=todo
    )


# Delete Route
@app.route('/delete/<int:id>')
def delete(id):

    todo = Todo.query.get_or_404(id)

    db.session.delete(todo)

    db.session.commit()

    # Backup after deleting task
    backup_database()

    return redirect(url_for('index'))


# Run App
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
