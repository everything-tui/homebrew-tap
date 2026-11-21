class YtmusicTui < Formula
  desc "YouTube Music in the terminal — a polished media-player TUI"
  homepage "https://github.com/everything-tui/ytmusic-tui"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/everything-tui/ytmusic-tui/releases/download/v0.3.0/ytmusic-tui-aarch64-apple-darwin.tar.xz"
      sha256 "4d9b99d230d29a9d2d007da048e805b3413101e02c1f332611d26ae09175db3d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/everything-tui/ytmusic-tui/releases/download/v0.3.0/ytmusic-tui-x86_64-apple-darwin.tar.xz"
      sha256 "fbc2c3791462f9535b8583db57797894ef935259cc59f26363ed01af8867e777"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/everything-tui/ytmusic-tui/releases/download/v0.3.0/ytmusic-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f2b921ff4d4b5719b47f0d42a322db27294bb6ae5a40cd0e0d53e5f855e6403c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/everything-tui/ytmusic-tui/releases/download/v0.3.0/ytmusic-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e4963fecf725bfbda7b40b38257141e043d039badd5ce8edff90ce52d9caf261"
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
      bin.install "ytmusic-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ytmusic-tui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ytmusic-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ytmusic-tui"
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
