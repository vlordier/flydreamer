# FlyDreamer — development tasks
# Usage: just <target>

# Train an FPV navigation agent
train:
	python dreamerv3/main.py \
		--configs fpv \
		--logdir logs/fpv_run

# Evaluate a trained FPV agent
eval:
	python dreamerv3/main.py \
		--configs fpv eval \
		--logdir logs/fpv_run

# Score training runs against baselines
score:
	python scripts/analyze_training.py

# Launch the BlocksV2 simulator (requires Unreal Engine build)
launch-blocks:
	bash scripts/launch_blocks_sim.sh

# Launch BlocksV2 in headless mode for training
launch-headless:
	bash scripts/launch_headless.sh

# Run ruff linting
lint:
	ruff check .
	ruff format --check .

# Run lint and fix
lint-fix:
	ruff check . --fix
	ruff format .

# Run tests
test:
	pytest embodied/tests -v

# Build Docker image
docker-build:
	docker build -f Dockerfile -t flydreamer img .

# Run Docker container (interactive)
docker-run:
	docker run -it --rm \
		-v $(PWD)/logs:/app/logs \
		flydreamer \
		bash

# Clean build artifacts
clean:
	rm -rf logs/ .pytest_cache/ dist/ *.egg-info/
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true

# Show help
show := --list
default:
	just --list
