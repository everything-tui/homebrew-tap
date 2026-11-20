class BwTui < Formula
  desc "Terminal UI for Vaultwarden"
  homepage "https://github.com/everything-tui/bw-tui"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/everything-tui/bw-tui/releases/download/v0.2.1/bw-tui-aarch64-apple-darwin.tar.xz"
      sha256 "6cb7ed6b58de139bf7dd66375d07c718b2355189b90142697139e87f46cce0b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/everything-tui/bw-tui/releases/download/v0.2.1/bw-tui-x86_64-apple-darwin.tar.xz"
      sha256 "e4e761765a29914b7b82b5a020de43b8eb89bd6ee57528ac90b5b6aacd5d48b3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/everything-tui/bw-tui/releases/download/v0.2.1/bw-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "707edbe5e43100f234c036a7d3d9371798b5b8bef105bf75cb12a1218f2c2a26"
    end
    if Hardware::CPU.intel?
      url "https://github.com/everything-tui/bw-tui/releases/download/v0.2.1/bw-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d1dafb1867078db1da215e8b20156fb1cd531b3b8747ce37cbb531596e3aedb1"
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
