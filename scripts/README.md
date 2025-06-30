# Scripts Directory

This directory contains automation scripts for the repository.

## update_blog_posts.py

Fetches the latest blog posts from [Phi's Tech Blog RSS feed](https://phiptech.com/feed/) and updates the `LATEST_BLOG_POSTS.md` file in the root directory.

### Features

- Fetches RSS feed from https://phiptech.com/feed/
- Parses RSS entries and extracts title, link, description, and publication date
- Formats content as clean markdown
- Handles HTML tag removal and text cleanup
- Includes error handling for network issues
- Limits to 10 most recent posts

### Dependencies

- `feedparser` - RSS/Atom feed parsing
- `requests` - HTTP requests

### Usage

```bash
# Install dependencies
pip install feedparser requests

# Run the script
python3 scripts/update_blog_posts.py
```

The script is designed to be run by GitHub Actions but can also be executed manually for testing.

### Automated Execution

This script is automatically executed daily at 6:00 AM UTC via GitHub Actions workflow `.github/workflows/update-blog-posts.yml`.