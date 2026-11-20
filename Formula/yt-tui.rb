class YtTui < Formula
  desc "YouTube Music in the terminal — a polished media-player TUI"
  homepage "https://github.com/everything-tui/ytmusic-tui"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/everything-tui/ytmusic-tui/releases/download/v0.1.0/yt-tui-aarch64-apple-darwin.tar.xz"
      sha256 "e535264b10b8e322a158132e39ccc0e54ca127fb11fc5a9ecbc147cee93c2e22"
    end
    if Hardware::CPU.intel?
      url "https://github.com/everything-tui/ytmusic-tui/releases/download/v0.1.0/yt-tui-x86_64-apple-darwin.tar.xz"
      sha256 "59d4d95a0979c7477cbe55678eb6f60a9cc9acd8e1a744918ea72008c7f9132f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/everything-tui/ytmusic-tui/releases/download/v0.1.0/yt-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4b86eb9a9bbcda326b4f8178574c2c72f610f4f0fb36313de46287ddfd8e69d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/everything-tui/ytmusic-tui/releases/download/v0.1.0/yt-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9434faa0298f69b526268e036785063a79b729f2e36434d2f04ab06943b34748"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "yt-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "yt-tui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "yt-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "yt-tui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
