"""Core utilities for python-uv-boilerplate."""

__version__ = "0.1.0"


def greet(name: str) -> str:
    """Greet someone by name.

    Args:
        name: The name of the person to greet

    Returns:
        A greeting message
    """
    return f"Hello, {name}!"


__all__ = ["greet"]
