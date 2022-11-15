### Battery test

laptop: Thinkpad t460s i5-6300u 12Gb

Brightness: 70%

Scenario:
  
  - repeat:
    - vscode (with WSL in win):
      - 3x(file, find, goto definition and back)
      - run complation with tests
    - browser:
      - google 123, scroll down/up, 5x reload page
      - open youtube 720p, watch 30s
    

| OS     |  time   |
|--------|---------|
| Arch   | 3:55:23 |
| Win 11 | 3:52:33 |
| Win 10 | 4:05:03 |
