#!/usr/bin/env python3
"""
Script to fetch latest blog posts from RSS feed and update LATEST_BLOG_POSTS.md
"""

import feedparser
import requests
from datetime import datetime
import sys
import os

RSS_FEED_URL = "https://phiptech.com/feed/"
OUTPUT_FILE = "LATEST_BLOG_POSTS.md"
MAX_POSTS = 10

def fetch_rss_feed():
    """Fetch and parse the RSS feed"""
    try:
        print(f"Fetching RSS feed from {RSS_FEED_URL}")
        
        # Set headers to mimic a browser request
        headers = {
            'User-Agent': 'Mozilla/5.0 (compatible; Blog Posts Updater/1.0; +https://github.com/phipcode/phiptechblog)'
        }
        
        response = requests.get(RSS_FEED_URL, timeout=30, headers=headers)
        response.raise_for_status()
        
        feed = feedparser.parse(response.content)
        
        if feed.bozo:
            print(f"Warning: Feed may have issues - {feed.bozo_exception}")
        
        print(f"Successfully parsed feed: {feed.feed.get('title', 'Unknown')}")
        print(f"Found {len(feed.entries)} entries")
        
        return feed
    except requests.RequestException as e:
        print(f"Error fetching RSS feed: {e}")
        print("This might be a temporary network issue. The workflow will retry on the next scheduled run.")
        sys.exit(1)
    except Exception as e:
        print(f"Error parsing RSS feed: {e}")
        sys.exit(1)

def format_post_date(entry):
    """Format the post date from the RSS entry"""
    try:
        if hasattr(entry, 'published_parsed') and entry.published_parsed:
            date_obj = datetime(*entry.published_parsed[:6])
            return date_obj.strftime("%B %d, %Y")
        elif hasattr(entry, 'updated_parsed') and entry.updated_parsed:
            date_obj = datetime(*entry.updated_parsed[:6])
            return date_obj.strftime("%B %d, %Y")
        else:
            return "Date unknown"
    except Exception:
        return "Date unknown"

def generate_markdown(feed):
    """Generate markdown content from RSS feed"""
    
    # Header
    markdown_content = f"""# Latest Blog Posts from Phi's Tech Blog

*Last updated: {datetime.now().strftime("%B %d, %Y at %H:%M UTC")}*

This file is automatically updated daily with the latest blog posts from [Phi's Tech Blog](https://phiptech.com).

---

"""
    
    # Process entries (limit to MAX_POSTS)
    entries = feed.entries[:MAX_POSTS]
    
    for i, entry in enumerate(entries, 1):
        title = entry.get('title', 'Untitled')
        link = entry.get('link', '#')
        summary = entry.get('summary', entry.get('description', ''))
        date = format_post_date(entry)
        
        # Clean up summary (remove HTML tags and limit length)
        if summary:
            import re
            summary = re.sub(r'<[^>]+>', '', summary)  # Remove HTML tags
            summary = summary.strip()
            if len(summary) > 200:
                summary = summary[:200] + "..."
        else:
            summary = "No description available."
        
        markdown_content += f"""## {i}. [{title}]({link})

**Published:** {date}

{summary}

[Read more →]({link})

---

"""
    
    # Footer
    markdown_content += f"""
## About Phi's Tech Blog

Visit [phiptech.com](https://phiptech.com) for more infrastructure, DevOps, and cloud technology content.

**RSS Feed:** {RSS_FEED_URL}
"""
    
    return markdown_content

def main():
    """Main function"""
    print("Starting blog posts update...")
    
    # Fetch RSS feed
    feed = fetch_rss_feed()
    
    if not feed.entries:
        print("No entries found in RSS feed")
        sys.exit(1)
    
    # Generate markdown
    markdown_content = generate_markdown(feed)
    
    # Write to file
    try:
        with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
            f.write(markdown_content)
        print(f"Successfully updated {OUTPUT_FILE}")
        print(f"Added {min(len(feed.entries), MAX_POSTS)} blog posts")
    except Exception as e:
        print(f"Error writing to {OUTPUT_FILE}: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()