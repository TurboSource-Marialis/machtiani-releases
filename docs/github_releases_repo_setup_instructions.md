
# Setting Up a GitHub Repository for CLI Tool Releases

Follow these steps to create a GitHub repository for hosting releases that can be used with your installation script.

## 1. Create a New GitHub Repository

1. Go to [GitHub](https://github.com).
2. Click on your profile icon in the top-right and select **Your repositories**.
3. Click the green **New** button to create a new repository.
4. Name your repository (e.g., `machtiani-releases`).
5. Set the repository to **Public** so users can download the binaries.
6. Optionally, add a **README.md** and a license.
7. Click **Create repository**.

## 2. Build Your CLI Tool Binaries

Compile your Go CLI tool for the supported platforms (macOS and Linux):

In the `machtiani/machtiani` folder in the machtiani monorepo:

```bash
./build.sh --release
```

## 3. Create a GitHub Release

1. Go to the repository page you just created.
2. Click on the **Releases** tab.
3. Click **Draft a new release**.
4. Add a **Tag version** (e.g. pre-release-abc1234) and give the release a title (e.g. Rolling Release - Commit abc1234)
5. **Upload the compiled binaries** (e.g., `machtiani-darwin-amd64`, `machtiani-linux-amd64`).
6. Add a description.
7. Click **Publish release**.

## 4. Obtain Download URLs

After the release is published, right-click on each binary link in the release and copy the URL. These URLs will look like:
- `https://github.com/turbosource-marialis/machtiani-releases/releases/download/pre-release-abc1234/machtiani-linux-amd64`
- `https://github.com/turbosource-marialis/machtiani-releases/releases/download/pre-release-abc1234/machtiani-darwin-arm64`
- `https://github.com/turbosource-marialis/machtiani-releases/releases/download/pre-release-abc1234/machtiani-darwin-amd64`

## 5. Update the Installation Script

Replace the `REPO` variable in your script with the actual GitHub release URL:

```bash
REPO="https://github.com/turbosource-marialis/machtiani-releases/releases/download/pre-release-abc1234"
```

Now your script can download the correct binaries based on the OS.

## 6. Test the Installation Script

Run the following command to test the script:

```bash
curl -L https://yourdomain.com/install.sh | bash
```

This will install the correct binary for macOS or Linux.

## 7. Provide Instructions in the README

Update your repository’s README with the installation instructions:

```markdown
## Installation

To install the CLI tool on macOS or Linux, run the following command:

### Using `curl`
```bash
curl -L https://yourdomain.com/install.sh | bash
```

### Using `wget`
```bash
wget -O - https://yourdomain.com/install.sh | bash
```
```

## 8. Optional: Automate Releases with GitHub Actions

You can set up a GitHub Actions workflow to automatically create new releases whenever you push new code.

---

By following these steps, your users will be able to install the tool with a simple command, and the binaries will be hosted on GitHub Releases.
