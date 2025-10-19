"""Logging utilities for python-uv-boilerplate."""

import logging
import sys

__version__ = "0.1.0"


def setup_logger(
    name: str,
    level: int = logging.INFO,
    format_string: str | None = None,
) -> logging.Logger:
    """Setup and configure a logger.

    Args:
        name: The name of the logger
        level: The logging level (default: INFO)
        format_string: Custom format string for log messages

    Returns:
        Configured logger instance
    """
    logger = logging.getLogger(name)
    logger.setLevel(level)

    if not logger.handlers:
        handler = logging.StreamHandler(sys.stdout)
        handler.setLevel(level)

        if format_string is None:
            format_string = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"

        formatter = logging.Formatter(format_string)
        handler.setFormatter(formatter)
        logger.addHandler(handler)

    return logger


__all__ = ["setup_logger"]
