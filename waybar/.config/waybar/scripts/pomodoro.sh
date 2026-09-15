#!/bin/bash

# Query pomodoro-cli for status
STATUS=$(pomodoro-cli status 2>/dev/null)

if [[ "$STATUS" == *"running"* ]]; then
    # Extract time remaining, e.g., "Time left: 12m34s"
    TIME_LEFT=$(echo "$STATUS" | grep "Time left" | awk '{print $3}')
    echo "{\"text\": \"$TIME_LEFT\", \"tooltip\": \"$STATUS\"}"
fi
