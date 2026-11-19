class BwTui < Formula
  desc "Terminal UI for Vaultwarden"
  homepage "https://github.com/everything-tui/bw-tui"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/everything-tui/bw-tui/releases/download/v0.2.0/bw-tui-aarch64-apple-darwin.tar.xz"
      sha256 "694d4e451be10fa45d170ef51a80e3fc1c3fdfd2fdcd83dc8a4509435393c3d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/everything-tui/bw-tui/releases/download/v0.2.0/bw-tui-x86_64-apple-darwin.tar.xz"
      sha256 "8dd1f287b5a111021457187a7fedd854b0489f391a19aa542e7b910e4636a908"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/everything-tui/bw-tui/releases/download/v0.2.0/bw-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a130b294f00d3d7ae83b5dcfe231ff6373d565bc405402ad0e7bc54b16bc5a47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/everything-tui/bw-tui/releases/download/v0.2.0/bw-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "240509dd9348a45dbc4d2f17339a25b914fc04f0c748177871ae1e3f63db502c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-pc-windows-gnu":             {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "bw-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bw-tui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "bw-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bw-tui"
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
