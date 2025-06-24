import markdown
from weasyprint import HTML
import sys
import os

def convert_md_to_pdf(input_file, output_file):
    if not os.path.isfile(input_file):
        print(f"❌ File not found: {input_file}")
        return

    with open(input_file, "r", encoding="utf-8") as f:
        md_content = f.read()

    html_content = markdown.markdown(md_content, extensions=['tables', 'fenced_code'])
    
    # Optional: Wrap HTML in a simple structure for styling
    html = f"""
    <html>
    <head>
        <meta charset="utf-8">
        <style>
            body {{ font-family: sans-serif; padding: 2em; }}
            code, pre {{ background-color: #f0f0f0; padding: 0.2em; }}
            table {{ border-collapse: collapse; width: 100%; }}
            th, td {{ border: 1px solid #ccc; padding: 8px; text-align: left; }}
        </style>
    </head>
    <body>
        {html_content}
    </body>
    </html>
    """

    HTML(string=html).write_pdf(output_file)
    print(f"✅ PDF generated: {output_file}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 md_to_pdf.py input.md output.pdf")
    else:
        convert_md_to_pdf(sys.argv[1], sys.argv[2])
