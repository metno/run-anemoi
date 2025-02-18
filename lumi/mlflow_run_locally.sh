#!/bin/bash


# Script to run MLflow on your local computer.
# First download mlflow logs from the LUMI server with rsync.
# Then open mlflow in web browser.


# Remote server details
REMOTE_USER="your_username"      # Change this
REMOTE_HOST="lumi.csc.fi"
REMOTE_PATH="/path/to/mlflow_logs/"  # Change this

# Local storage path
LOCAL_PATH="$HOME/mlflow_logs/"


# Rsync command to sync new files only
rsync -avz --update --progress "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH" "$LOCAL_PATH"
# Notify the user
echo "MLlflow logs synced succesfully to $LOCAL_PATH"

# Start MLflow UI
if lsof -i :5000 > /dev/null; then
    echo "MLflow is already running."
else
    echo "Starting MLflow..."
    mlflow ui --backend-store-uri "$LOCAL_PATH" &
    
    # Wait for the MLflow server to start 
    sleep 5
fi


# Open MLflow UI in the default browser
echo "Opening MLflow UI in browser..."
xdg-open "http://127.0.0.1:5000"
