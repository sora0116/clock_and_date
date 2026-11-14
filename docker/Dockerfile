FROM eclipse-temurin:17-jdk-jammy

ARG CMDLINE_TOOLS=11076708
ARG GRADLE_VERSION=8.9
ENV ANDROID_HOME=/opt/android-sdk \
    GRADLE_USER_HOME=/root/.gradle
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:/opt/gradle/bin

RUN apt-get update && apt-get install -y --no-install-recommends unzip curl \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $ANDROID_HOME/cmdline-tools \
 && curl -fsSL -o /tmp/tools.zip https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_TOOLS}_latest.zip \
 && unzip -q /tmp/tools.zip -d $ANDROID_HOME/cmdline-tools \
 && mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest \
 && rm /tmp/tools.zip \
 && yes | sdkmanager --licenses > /dev/null \
 && sdkmanager "platforms;android-35" "build-tools;35.0.0" "platform-tools"

RUN curl -fsSL -o /tmp/gradle.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
 && unzip -q /tmp/gradle.zip -d /opt \
 && mv /opt/gradle-${GRADLE_VERSION} /opt/gradle \
 && rm /tmp/gradle.zip

WORKDIR /project
CMD ["gradle", "--no-daemon", "assembleDebug"]
