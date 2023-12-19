#!/bin/bash
# Kafka Health Check Script

echo "===============Healthcheck================"
# Produce a message to a test topic
echo "Producing test message..."
if ! echo "Test message" | kafka-console-producer --broker-list localhost:9092 --topic test-healthcheck; then
    echo "Failed to produce message"
    exit 1
fi

echo "Consuming test message..."
# Consume the message from the test topic
if ! kafka-console-consumer --bootstrap-server localhost:9092 --topic test-healthcheck --from-beginning --timeout-ms 10000 | grep "Test message"; then
    echo "Failed to consume message"
    exit 1
fi

echo "Health check passed"
exit 0

# Keep the script running
wait